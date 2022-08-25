import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../widgets/checkout_information.dart';

class SuccessBookingPage extends StatelessWidget {
  const SuccessBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckoutInformationWidget(
      icon: const Icon(
        Icons.check_circle_rounded,
        size: 64,
        color: Colors.green
      ),
      title: AutoSizeText(
        'Payment Successful!',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.green,
            ),
        maxLines: 1,
      ),
      subtitle: const AutoSizeText(
        "Your payment was successful! Thanks for using our application.",
        textAlign: TextAlign.center,
      ),
    );
  }
}
