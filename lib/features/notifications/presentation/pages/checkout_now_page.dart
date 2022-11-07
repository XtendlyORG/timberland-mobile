import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/core/utils/session.dart';

class CheckOutNowPage extends StatelessWidget {
  const CheckOutNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedSafeArea(
      child: TimberlandScaffold(
        extendBodyBehindAppbar: true,
        showNavbar: Session().isLoggedIn,
        disableBackButton: !Session().isLoggedIn,
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
                            const Icon(Icons.notification_important_outlined),
                            const SizedBox(
                              height: kVerticalPadding,
                            ),
                            AutoSizeText(
                              'Check Out Now',
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
                              "Please confirm that you are safely home.",
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
                      // TODO: Call checkout event
                      context.goNamed(Routes.trails.name);
                    },
                    child: const Text('Check Out'),
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
