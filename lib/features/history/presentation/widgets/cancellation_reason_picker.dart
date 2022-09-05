import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/constants/padding.dart';
import '../../../../core/presentation/widgets/widgets.dart';

class CancellationReasonPicker extends StatefulWidget {
  const CancellationReasonPicker({Key? key}) : super(key: key);

  @override
  State<CancellationReasonPicker> createState() =>
      _CancellationReasonPickerState();
}

class _CancellationReasonPickerState extends State<CancellationReasonPicker> {
  late String reason;
  final reasons = ['Reason 1', 'Reason 2', "Reason 3", 'Reason 4'];
  @override
  void initState() {
    super.initState();
    reason = "Test";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...reasons
            .map((e) => RadioListTile(
                  value: e,

                  title: Text(
                    e,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  groupValue: reason,
                  onChanged: (val) {
                    setState(() {
                      reason = val as String;
                    });
                  },
                ))
            .toList(),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kVerticalPadding*1.5),
            child: FilledTextButton(
              onPressed: () {
                Navigator.pop(context);
                log(reason);
              },
              child: const Text(
                'Confirm',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
