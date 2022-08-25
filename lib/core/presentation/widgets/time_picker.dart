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
  late FixedExtentScrollController hourCtrl, minuteCtrl;
  late List<int> hours;

  @override
  void initState() {
    super.initState();

    final TimeOfDay initialTime =
        widget.initialTime ?? const TimeOfDay(hour: 6, minute: 0);
    hour = initialTime.hour;
    minute = initialTime.minute;
    hours = const [1, 2, 6, 7, 8, 9, 10, 11, 12];
    hourCtrl = FixedExtentScrollController(initialItem: hours.indexOf(hour));
    minuteCtrl = FixedExtentScrollController(initialItem: minute);
  }

  void getTime() {
    if (hour == 14) {
      if (minute > 30) {
        minute = 30;
      }
    } else {
      setState(() {});
    }

    hourCtrl.jumpToItem(hours.indexOf(
      hour > 12 ? hour - 12 : hour,
    ));
    minuteCtrl.jumpToItem(minute);
    widget.onChange(
      TimeOfDay(
        hour: hour,
        minute: minute,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) {
        getTime();
      },
      child: SizedBox(
        height: widget.height,
        child: Row(
          children: [
            Expanded(
              child: SpinnerWheel<int>(
                textStyle: widget.textStyle,
                items: hours,
                controller: hourCtrl,
                onChange: (val) {
                  if (hour < 12 && (val < 3 || val == 12)) {
                    setState(() {});
                  } else if (hour >= 12 && (val > 3 || val != 12)) {
                    setState(() {});
                  }
                  hour = (val < 3 ? val + 12 : val);
                },
              ),
            ),
            SizedBox(
              child: Text(
                ':',
                style: widget.textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: widget.textStyle.fontSize != null
                      ? widget.textStyle.fontSize! * 1.75
                      : null,
                ),
              ),
            ),
            Expanded(
              child: SpinnerWheel<int>(
                textStyle: widget.textStyle,
                items: List.generate(hour != 14 ? 60 : 31, (index) => index),
                fix2Digits: true,
                controller: minuteCtrl,
                onChange: (val) {
                  minute = val;
                },
              ),
            ),
            Expanded(
              child: Text(
                hour >= 12 ? 'PM' : 'AM',
                style: widget.textStyle.copyWith(
                    fontSize: (widget.textStyle.fontSize ?? 12) * 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpinnerWheel<T> extends StatelessWidget {
  const SpinnerWheel({
    Key? key,
    required this.textStyle,
    required this.items,
    required this.onChange,
    this.height = 90,
    this.fix2Digits = false,
    this.controller,
  }) : super(key: key);

  final TextStyle textStyle;
  final List items;
  final void Function(T val) onChange;
  final double height;
  final bool fix2Digits;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      itemExtent: height / 3,
      useMagnifier: true,
      magnification: 1.5,
      controller: controller,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) {
        onChange(items[index]);
      },
      childDelegate: ListWheelChildLoopingListDelegate(
        children: items.map(
          (item) {
            String text = item.toString();

            text = fix2Digits && text.length < 2 ? '0$text' : text;
            return Container(
              height: height / 3,
              alignment: Alignment.center,
              child: Text(
                text,
                style: textStyle,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
