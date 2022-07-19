// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:timberland_biketrail/core/constants/constants.dart';

class CustomDatePicker extends StatelessWidget {
  final Function(Object?)? onSumbit;
  final bool showTodayButton;
  final List<DateTime>? blackoutDates;
  final bool enablePastDates;
  final DateTime? minDate;
  final DateTime? initialSelectedDate;
  const CustomDatePicker({
    Key? key,
    this.onSumbit,
    this.showTodayButton = false,
    this.blackoutDates,
    this.enablePastDates = true,
    this.minDate,
    this.initialSelectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(kVerticalPadding),
        child: SfDateRangePicker(
          enablePastDates: enablePastDates,
          showTodayButton: showTodayButton,
          toggleDaySelection: true,
          cancelText: "Cancel",
          headerStyle: DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: Theme.of(context).textTheme.titleMedium,
          ),
          minDate: minDate,
          monthViewSettings: DateRangePickerMonthViewSettings(
            blackoutDates: blackoutDates,
            weekendDays: const [7, 6],
            showTrailingAndLeadingDates: true,
            dayFormat: 'EEE',
            firstDayOfWeek: 1,
          ),
          monthCellStyle: const DateRangePickerMonthCellStyle(
            blackoutDatesDecoration: BoxDecoration(
              color: Colors.red,
            ),
            blackoutDateTextStyle: TextStyle(
              decoration: TextDecoration.none,
            ),
          ),
          navigationMode: DateRangePickerNavigationMode.snap,
          selectionShape: DateRangePickerSelectionShape.rectangle,
          showNavigationArrow: true,
          initialSelectedDate: initialSelectedDate,
          showActionButtons: true,
          onSubmit: (val) {
            if (onSumbit != null) {
              onSumbit!(val);
            }
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
