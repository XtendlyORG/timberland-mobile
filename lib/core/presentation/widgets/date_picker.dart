// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/features/booking/data/models/blocked_booking_model.dart';
import 'package:timberland_biketrail/features/constants/helpers.dart';

class CustomDatePicker extends StatelessWidget {
  final Function(Object?)? onSumbit;
  final bool showTodayButton;
  final List<DateTime>? blackoutDates;
  final bool enablePastDates;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? initialSelectedDate;
  final bool isBooking;
  final List<BlockedBookingsModel>? blockedBookings;
  const CustomDatePicker({
    Key? key,
    this.onSumbit,
    this.showTodayButton = false,
    this.blackoutDates,
    this.enablePastDates = true,
    this.minDate,
    this.maxDate,
    this.initialSelectedDate,
    required this.isBooking,
    this.blockedBookings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(kVerticalPadding),
        child: SfDateRangePicker(
          maxDate: maxDate,
          enablePastDates: enablePastDates,
          showTodayButton: showTodayButton,
          selectableDayPredicate: (date) {

            if (!isBooking) {
              return true;
            }
            if (date == DateTime(2024, 02, 18)) {
              return false;
            }

            // Disable Dates on Mondays
            // if (date.weekday == 1) {
            //   return false;
            // }

            if(blockedBookings != null){
              // Check if selected date is within range of any of the blocked dates
              List<BlockedBookingsModel> tempList = blockedBookings!.where((bk) => (bk.isBlocked ?? true) && bk.status == "Active").toList();
              List<int> bookingsWithinRange = [];
              for (var booking in tempList) {
                bool isCurrentWithinRange = dateIsWithinRange(date, booking.startDate, booking.endDate);
                if(isCurrentWithinRange){
                  bookingsWithinRange.add(booking.bookingId ?? 0);
                }
              }

              return !bookingsWithinRange.isNotEmpty;
            }

            return true;
          },
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
