// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../core/constants/padding.dart';
import '../../../../../core/themes/timberland_color.dart';

class CancelBookingDialog extends StatelessWidget {
  final Widget content;
  const CancelBookingDialog({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      contentPadding: EdgeInsets.zero,
      content: Container(
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding,vertical: kVerticalPadding),
              child: content,
            ),
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
                        Navigator.pop(context, true);
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
