import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../constants/padding.dart';
import '../../../themes/timberland_color.dart';
import 'custom_dialog.dart';

class PermanentlyLockedDialog extends StatelessWidget {
  const PermanentlyLockedDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
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
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kVerticalPadding,
                ),
                child: AutoSizeText(
                  'Permanenly Locked',
                  maxLines: 1,
                  minFontSize: 16,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            const SizedBox(height: kVerticalPadding),
            Icon(
              Icons.lock,
              color: Theme.of(context).primaryColor,
              size: 48,
            ),
            const SizedBox(height: kVerticalPadding),
            AutoSizeText(
              'Unlock your device with PIN and try again.',
              textAlign: TextAlign.center,
              maxLines: 2,
              minFontSize: 12,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: kVerticalPadding / 2),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ),
            const SizedBox(height: kVerticalPadding / 2)
          ],
        ),
      ),
    );
  }
}
