// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class NotificationBanner extends StatelessWidget {
  const NotificationBanner({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: kToolbarHeight / 2),
      decoration: BoxDecoration(
        color: TimberlandColor.background.withOpacity(.5),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: TimberlandColor.linearGradient,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                  vertical: kVerticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/logo-icon.png',
                          height: 32,
                          width: 32,
                        ),
                        const SizedBox(width: kVerticalPadding),
                        Text(
                          'Timberland',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          'now',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: kVerticalPadding),
                    Text(
                      'Check Out Now',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: TimberlandColor.primary),
                    ),
                    Text(
                      'Please confirm that you are safely home.',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: .7,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: kVerticalPadding,
                  horizontal: kHorizontalPadding,
                ),
                child: FilledTextButton(
                  onPressed: onPressed,
                  child: const Text('Check Out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
