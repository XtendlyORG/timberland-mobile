import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../widgets/payment_history_widget.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimberlandScaffold(
      titleText: 'Payment History',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:kVerticalPadding,vertical: kHorizontalPadding),
        child: Column(
          children: [
            ...List.generate(
              5,
              (index) => const Padding(
                padding: EdgeInsets.only(bottom: kVerticalPadding),
                child: PaymentHistoryWidget()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
