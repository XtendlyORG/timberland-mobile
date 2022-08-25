import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/timberland_color.dart';
import '../widgets/checkout_information.dart';

class FailedBookingPage extends StatelessWidget {
  const FailedBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckoutInformationWidget(
      icon: Container(
        height: 64,
        width: 64,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: TimberlandColor.secondaryColor,
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.close,
          color: TimberlandColor.background,
          size: 48,
        ),
      ),
      title: AutoSizeText(
        'Payment Failed!',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: TimberlandColor.secondaryColor,
            ),
        maxLines: 1,
      ),
      subtitle: const AutoSizeText(
        "Something went wrong. Don't worry! Let's try again",
        textAlign: TextAlign.center,
      ),
    );
  }
}
