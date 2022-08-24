import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class SuccessBookingPage extends StatelessWidget {
  const SuccessBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimberlandScaffold(
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
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                            size: 64,
                          ),
                          const SizedBox(
                            height: kVerticalPadding,
                          ),
                          AutoSizeText(
                            'Payment Successful!',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.green,
                                ),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: kVerticalPadding,
                          ),
                          const AutoSizeText(
                            "Your payment was successful! Thanks for using our application.",
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
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
