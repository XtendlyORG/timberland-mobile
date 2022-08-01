import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/router/router.dart';

class EmergencyDialog extends StatelessWidget {
  const EmergencyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(
        "Call Timberland Bike Park",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This action will contact our nearest admin station to your current location.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: kVerticalPadding,
            ),
            Text(
              'Are you sure you want to call Timberland Admin?',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('NO'),
        ),
        TextButton(
          onPressed: () {
            context.goNamed(Routes.emergency.name);
            Navigator.pop(context);
          },
          child: const Text('YES'),
        ),
      ],
    );
  }
}
