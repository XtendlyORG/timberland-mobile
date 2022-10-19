// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/bloc/app_info_bloc.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/contact_form.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppInfoBloc, AppInfoState>(
      listenWhen: (previous, current) => current is ContactState,
      listener: (context, state) {
        if (state is SendingInquiry) {
          showLoading('Sending your message...');
        }

        if (state is InquiryError) {
          showError(state.errorMessage);
        }
        if (state is InquirySent) {
          showSuccess('Your message was sent');
        }
      },
      child: DecoratedSafeArea(
        child: TimberlandScaffold(
          titleText: 'Contact Us',
          extendBodyBehindAppbar: true,
          showNavbar: Session().isLoggedIn,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: kVerticalPadding),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                        Uri.parse('https://www.facebook.com/ridetimberland.ph'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Image.asset(
                      'assets/icons/facebook-icon.png',
                      scale: 2,
                    ),
                  ),
                  const SizedBox(width: kVerticalPadding),
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                        Uri.parse('https://www.twitter.com/ridetimberland.ph'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Image.asset(
                      'assets/icons/twitter-icon.png',
                      scale: 2,
                    ),
                  ),
                  const SizedBox(width: kVerticalPadding),
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                        Uri.parse('https://www.instagram.com/ridetimberland.ph'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Image.asset(
                      'assets/icons/instagram-icon.png',
                      scale: 2,
                    ),
                  ),
                ],
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                  vertical: kHorizontalPadding,
                ),
                child: const ContactsPageForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
