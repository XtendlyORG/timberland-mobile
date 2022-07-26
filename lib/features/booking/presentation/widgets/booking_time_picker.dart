import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
          builder: (context) {
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
              content: Row(
                children: [
                  Expanded(
                    child: ExcludeFocus(
                      child: TextFormField(
                        controller: startCtrl,
                        enableInteractiveSelection: false,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          suffixIconConstraints: const BoxConstraints(
                            maxWidth: 20,
                          ),
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(left: 8),
                          suffixIcon: SizedBox(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      start = TimeOfDay(
                                        hour: start.hour + 1,
                                        minute: start.minute,
                                      );
                                      startCtrl.text = start.format(context);
                                      if (start.hour >= end.hour) {
                                        end = TimeOfDay(
                                          hour: start.hour + 1,
                                          minute: 0,
                                        );
                                        endCtrl.text = end.format(context);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      start = TimeOfDay(
                                        hour: start.hour - 1,
                                        minute: start.minute,
                                      );
                                      startCtrl.text = start.format(context);
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kVerticalPadding),
                    child: Text('to'),
                  ),
                  Expanded(
                    child: ExcludeFocus(
                      child: TextFormField(
                        controller: endCtrl,
                        enableInteractiveSelection: false,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          suffixIconConstraints: const BoxConstraints(
                            maxWidth: 20,
                          ),
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(left: 8),
                          suffixIcon: SizedBox(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      end = TimeOfDay(
                                        hour: end.hour + 1,
                                        minute: end.minute,
                                      );
                                      endCtrl.text = end.format(context);
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      end = TimeOfDay(
                                        hour: end.hour - 1,
                                        minute: end.minute,
                                      );
                                      endCtrl.text = end.format(context);
                                      if (start.hour >= end.hour) {
                                        start = TimeOfDay(
                                          hour: end.hour - 1,
                                          minute: 0,
                                        );
                                        startCtrl.text = start.format(context);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
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
