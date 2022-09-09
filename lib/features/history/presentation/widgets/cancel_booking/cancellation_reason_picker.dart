import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../core/constants/padding.dart';
import '../../../../../core/presentation/widgets/widgets.dart';

class CancellationReasonPicker extends StatefulWidget {
  const CancellationReasonPicker({Key? key}) : super(key: key);

  @override
  State<CancellationReasonPicker> createState() =>
      _CancellationReasonPickerState();
}

class _CancellationReasonPickerState extends State<CancellationReasonPicker> {
  String? reason;
  late final TextEditingController otherReasonCtrl;
  late bool textFieldEnabled;
  final reasons = [
    'Change of mind',
    'Weather Reasons',
    "Change of booking date",
    'Others (Please specify):',
  ];
  @override
  void initState() {
    super.initState();
    textFieldEnabled = false;
    otherReasonCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...reasons.map((e) {
          if (e.contains('Others')) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  value: otherReasonCtrl.text,
                  title: Text(
                    e,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  groupValue: reason,
                  onChanged: (val) {
                    textFieldEnabled = true;
                    setState(() {
                      reason = val as String;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kHorizontalPadding * 1.75,
                    right: kVerticalPadding * 1.5,
                    bottom: kVerticalPadding,
                  ),
                  child: TextFormField(
                    controller: otherReasonCtrl,
                    enabled: textFieldEnabled,
                    maxLines: 2,
                  ),
                ),
              ],
            );
          }
          return RadioListTile(
            value: e,
            title: Text(
              e,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            groupValue: reason,
            onChanged: (val) {
              if (textFieldEnabled) textFieldEnabled = false;
              setState(() {
                reason = val as String;
              });
            },
          );
        }).toList(),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              left: kVerticalPadding * 1.5,
              right: kVerticalPadding * 1.5,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: FilledTextButton(
              onPressed: () {
                textFieldEnabled ? reason = otherReasonCtrl.text : null;
                Navigator.pop(context);
                log(reason ?? "Not specifeid");
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