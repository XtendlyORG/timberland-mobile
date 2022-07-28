// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class TimePickerSpinner extends StatefulWidget {
  const TimePickerSpinner({
    Key? key,
    this.initialTime,
    required this.textStyle,
    required this.onChange,
    this.height = 90,
  }) : super(key: key);
  final TimeOfDay? initialTime;
  final TextStyle textStyle;
  final void Function(TimeOfDay time) onChange;
  final double height;

  @override
  State<TimePickerSpinner> createState() => _TimePickerSpinnerState();
}

class _TimePickerSpinnerState extends State<TimePickerSpinner> {
  late int hour, minute;
  late bool isMorning;

  @override
  void initState() {
    super.initState();
    final TimeOfDay initialTime = widget.initialTime ?? TimeOfDay.now();
    isMorning = initialTime.hour < 12;
    hour = isMorning ? initialTime.hour : initialTime.hour - 12;
    minute = initialTime.minute;
  }

  void getTime() {
    hour = isMorning
        ? hour < 12
            ? hour
            : hour - 12
        : hour > 12
            ? hour
            : hour + 12;
    widget.onChange(
      TimeOfDay(
        hour: hour,
        minute: minute,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        children: [
          Expanded(
            child: SpinnerWheel(
              textStyle: widget.textStyle,
              count: 12,
              initialValue: hour,
              onChange: (val) {
                hour = val;
                getTime();
              },
            ),
          ),
          Expanded(
            child: SpinnerWheel(
              textStyle: widget.textStyle,
              count: 60,
              startFromZero: true,
              initialValue: minute,
              onChange: (val) {
                minute = val;
                getTime();
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              height: widget.height,
              child: ListWheelScrollView(
                itemExtent: widget.height / 3,
                controller:
                    FixedExtentScrollController(initialItem: isMorning ? 0 : 1),
                physics: const FixedExtentScrollPhysics(),
                useMagnifier: true,
                magnification: 1.5,
                onSelectedItemChanged: (index) {
                  isMorning = index == 0;
                  getTime();
                },
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: widget.height / 3,
                    child: Text(
                      'AM',
                      style: widget.textStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: widget.height / 3,
                    child: Text(
                      'PM',
                      style: widget.textStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpinnerWheel extends StatelessWidget {
  const SpinnerWheel({
    Key? key,
    required this.initialValue,
    required this.textStyle,
    required this.count,
    this.startFromZero = false,
    required this.onChange,
    this.height = 90,
  }) : super(key: key);
  final int initialValue;
  final TextStyle textStyle;
  final int count;
  final bool startFromZero;
  final void Function(int val) onChange;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      itemExtent: height / 3,
      controller: FixedExtentScrollController(
          initialItem: startFromZero ? initialValue : initialValue - 1),
      useMagnifier: true,
      magnification: 1.5,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) {
        onChange(startFromZero ? index : index + 1);
      },
      childDelegate: ListWheelChildLoopingListDelegate(
        children: List<Widget>.generate(
          count,
          (index) => Container(
            height: height / 3,
            alignment: Alignment.center,
            child: Text(
              startFromZero ? '$index' : '${index + 1}',
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
