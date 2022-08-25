// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/presentation/widgets/time_picker.dart';
import 'package:timberland_biketrail/core/utils/validators/non_empty_validator.dart';

import '../../../../core/constants/constants.dart';

class BookingTimePicker extends StatefulWidget {
  const BookingTimePicker({
    Key? key,
    this.enabled = false,
    required this.controller,
    required this.onSubmit,
  }) : super(key: key);

  final bool enabled;
  final TextEditingController controller;
  final void Function(Object?) onSubmit;

  @override
  State<BookingTimePicker> createState() => _BookingTimePickerState();
}

class _BookingTimePickerState extends State<BookingTimePicker> {
  late TimeOfDay start;
  late TextEditingController startCtrl;

  @override
  void initState() {
    super.initState();
    start = const TimeOfDay(
      hour: 6,
      minute: 0,
    );

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      startCtrl = TextEditingController(text: start.format(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      enableInteractiveSelection: false,
      validator: (val) {
        return nonEmptyValidator(val,
            errorMessage: 'Please select a take off time');
      },
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              final TextStyle style = Theme.of(ctx)
                  .textTheme
                  .bodySmall!
                  .copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor);

              return AlertDialog(
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('CANCEL'),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.controller.text = DateFormat('hh:mm a').format(
                        DateTime(
                          0,
                          0,
                          0,
                          start.hour,
                          start.minute,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('DONE'),
                  ),
                ],
                contentPadding: const EdgeInsets.only(
                  left: kVerticalPadding,
                  right: kVerticalPadding,
                  top: kVerticalPadding,
                ),
                content: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: TimePickerSpinner(
                          initialTime: start,
                          textStyle: style,
                          onChange: (time) {
                            start = time;
                            log('start :${start.format(context)}');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      decoration: InputDecoration(
        hintText: 'Choose Time',
        prefixIcon: Icon(
          Icons.watch_later_outlined,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
