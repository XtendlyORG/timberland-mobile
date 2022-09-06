import 'package:flutter/material.dart';

import '../../../../../core/constants/padding.dart';
import '../../../../../core/themes/timberland_color.dart';

class CancelBookingDialog extends StatelessWidget {
  const CancelBookingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      contentPadding: EdgeInsets.zero,
      content: Container(
        constraints: const BoxConstraints(maxHeight: 200),
        decoration: BoxDecoration(
          gradient: TimberlandColor.linearGradient,
        ),
        padding: const EdgeInsets.only(
          top: kVerticalPadding,
          left: kVerticalPadding,
          right: kVerticalPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Text(
                'Are you sure, you want to cancel this booking?',
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context,true);
                      },
                      child: const Text('Yes'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: VerticalDivider(
                      thickness: 1.5,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
