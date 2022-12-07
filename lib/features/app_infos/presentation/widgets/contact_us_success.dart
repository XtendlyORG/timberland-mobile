// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/core/utils/session.dart';

class ContactUsThankyouPage extends StatelessWidget {
  const ContactUsThankyouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedSafeArea(
      child: TimberlandScaffold(
        extendBodyBehindAppbar: true,
        showNavbar: Session().isLoggedIn,
        body: Container(
          height: MediaQuery.of(context).size.height - kToolbarHeight * 2.75,
          constraints: const BoxConstraints(
            minHeight: 400,
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: TimberlandColor.linearGradient,
                  ),
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              height: kHorizontalPadding,
                            ),
                            Image.asset(
                              'assets/images/thankyou-page-img.png',
                            ),
                            const SizedBox(
                              height: kVerticalPadding,
                            ),
                            AutoSizeText(
                              'We received your message',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: TimberlandColor.primary,
                                  ),
                            ),
                            const SizedBox(
                              height: kVerticalPadding,
                            ),
                            const AutoSizeText(
                              "We will reach you with your email address soon. Thank you!",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: kHorizontalPadding,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kHorizontalPadding,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledTextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Go Back'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
