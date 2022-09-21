// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/bloc/app_info_bloc.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/contact_form.dart';

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
      child: TimberlandScaffold(
        titleText: 'Contact Us',
        extendBodyBehindAppbar: true,
        showNavbar: Session().isLoggedIn,
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding * 3,
          ),
          constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
          child: const ContactsPageForm(),
        ),
      ),
    );
  }
}
