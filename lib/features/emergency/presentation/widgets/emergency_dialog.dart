import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class EmergencyDialog extends StatelessWidget {
  const EmergencyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: const Alignment(0, .5),
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
            Text(
              'By pressing YES, the application will look into the nearest admin that will assist you for emergency purposes.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
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
                        Navigator.pop(context);
                      },
                      child: const Text('CANCEL'),
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
                        context.goNamed(Routes.emergency.name);
                        Navigator.pop(context);
                      },
                      child: const Text('YES'),
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
