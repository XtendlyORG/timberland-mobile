import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/timberland_color.dart';
import '../widgets/checkout_information.dart';

class CancelledBookingPage extends StatelessWidget {
  const CancelledBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckoutInformationWidget(
      icon: const Icon(
        Icons.error,
        color: TimberlandColor.secondaryColor,
        size: 64,
      ),
      title: AutoSizeText(
        'Payment Cancelled!',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: TimberlandColor.secondaryColor,
            ),
        maxLines: 1,
      ),
      subtitle: const AutoSizeText(
        "Your payment was cancelled!Thanks for using our application.",
        textAlign: TextAlign.center,
      ),
    );
  }
}
