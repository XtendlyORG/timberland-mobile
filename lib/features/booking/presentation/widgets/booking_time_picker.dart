// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:timberland_biketrail/core/presentation/widgets/time_picker.dart';

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
  late TimeOfDay end;
  late TextEditingController startCtrl;
  late TextEditingController endCtrl;

  @override
  void initState() {
    super.initState();
    start = TimeOfDay(
      hour: TimeOfDay.now().hour,
      minute: 0,
    );
    end = TimeOfDay(
      hour: start.hour + 1,
      minute: 0,
    );
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      startCtrl = TextEditingController(text: start.format(context));
      endCtrl = TextEditingController(text: end.format(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      enableInteractiveSelection: false,
      style: Theme.of(context).textTheme.bodyText1,
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              final TextStyle _style = Theme.of(ctx)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold);

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
                      widget.controller.text =
                          '${start.format(context)} - ${end.format(context)}';
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
                        child: ExcludeFocus(
                          child: TimePickerSpinner(
                            initialTime: TimeOfDay.now(),
                            textStyle: _style,
                            onChange: (time) {
                              start = time;
                              log('start :${start.format(context)}');
                            },
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kVerticalPadding),
                        child: Text('to'),
                      ),
                      Expanded(
                        child: ExcludeFocus(
                          child: TimePickerSpinner(
                            initialTime: TimeOfDay(
                              hour: TimeOfDay.now().hour + 1,
                              minute: TimeOfDay.now().minute,
                            ),
                            textStyle: _style,
                            onChange: (time) {
                              end = time;
                              log('end :${end.format(context)}');
                            },
                          ),
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
