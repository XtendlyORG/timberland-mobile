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
    required this.selectedDate,
  }) : super(key: key);

  final bool enabled;
  final TextEditingController controller;
  final void Function(Object?) onSubmit;
  final DateTime? selectedDate;

  @override
  State<BookingTimePicker> createState() => _BookingTimePickerState();
}

class _BookingTimePickerState extends State<BookingTimePicker> {
  late TimeOfDay start;
  late TextEditingController startCtrl;
  bool isTimeValid = true;

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
        _checkTimeValidity((_) {});
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
                contentPadding: const EdgeInsets.only(
                  left: kVerticalPadding,
                  right: kVerticalPadding,
                  top: kVerticalPadding,
                ),
                content: StatefulBuilder(builder: (context, stateSetter) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: TimePickerSpinner(
                                initialTime: start,
                                textStyle: style,
                                onChange: (time) {
                                  start = time;
                                  _checkTimeValidity(stateSetter);
                                  // log('start :${start.format(context)}');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: isTimeValid
                                ? () {
                                    widget.controller.text =
                                        DateFormat('hh:mm a').format(
                                      DateTime(
                                        0,
                                        0,
                                        0,
                                        start.hour,
                                        start.minute,
                                      ),
                                    );
                                    widget.onSubmit(start);
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: const Text('DONE'),
                          ),
                        ],
                      )
                    ],
                  );
                }),
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

  void _checkTimeValidity(StateSetter stateSetter) {
    DateTime currentDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    TimeOfDay currentTime = TimeOfDay.now();

    if (widget.selectedDate != null && widget.selectedDate == currentDate) {
      if (currentTime.hour == start.hour && currentTime.minute > start.minute ||
          currentTime.hour > start.hour) {
        if (isTimeValid) {
          setState(() {
            isTimeValid = false;
            stateSetter(() {});
          });
        }
      } else {
        if (!isTimeValid) {
          setState(() {
            isTimeValid = true;
          });

          stateSetter(() {});
        }
      }
    } else if (!isTimeValid) {
      setState(() {
        isTimeValid = true;
      });
    }
  }
}
