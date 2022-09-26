// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class CheckoutInformationWidget extends StatelessWidget {
  const CheckoutInformationWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final Widget icon;
  final Widget title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return DecoratedSafeArea(
      child: TimberlandScaffold(
        extendBodyBehindAppbar: true,
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
                            icon,
                            const SizedBox(
                              height: kVerticalPadding,
                            ),
                            title,
                            const SizedBox(
                              height: kVerticalPadding,
                            ),
                            subtitle,
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
                    child: const Text('Done'),
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
