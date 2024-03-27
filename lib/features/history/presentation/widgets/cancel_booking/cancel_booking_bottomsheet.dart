import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';

import '../../../../../core/themes/timberland_color.dart';
import 'cancellation_reason_picker.dart';

class CancelBookingBottomSheet extends StatelessWidget {
  const CancelBookingBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        gradient: TimberlandColor.linearGradient,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: kHorizontalPadding,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Select Cancellation Reason',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            Container(
              color: TimberlandColor.lightBlue,
              padding: const EdgeInsets.symmetric(horizontal: kVerticalPadding * 1.5, vertical: kVerticalPadding),
              child: Row(
                children: const [
                  Icon(
                    Icons.error_rounded,
                    color: TimberlandColor.primary,
                  ),
                  SizedBox(
                    width: kVerticalPadding,
                  ),
                  Expanded(
                    child: Text(
                      "Please select a cancellation reason. When you cancel a booking, it is not refundable.",
                    ),
                  ),
                  /*  Expanded(
                    child: Text(
                      "Please select a cancellation reason. When you cancel a booking, you will get a FREE pass that you can consume within four months.",
                    ),
                  ), */
                ],
              ),
            ),
            const SizedBox(
              height: kVerticalPadding,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                CancellationReasonPicker(),
                SizedBox(
                  height: kVerticalPadding,
                ),
                SizedBox(
                  height: kHorizontalPadding,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
