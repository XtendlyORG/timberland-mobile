// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/features/booking/data/models/blocked_booking_model.dart';
import 'package:timberland_biketrail/features/constants/helpers.dart';

import '../../../../core/presentation/widgets/date_picker.dart';
import '../../../../core/utils/validators/non_empty_validator.dart';

class BlockedBookingDatePicker extends StatelessWidget {
  const BlockedBookingDatePicker({
    Key? key,
    this.enabled = false,
    required this.controller,
    required this.onSubmit,
    this.selectedTime,
    required this.blockedBookings,
    required this.isDateLoaded,
  }) : super(key: key);

  final bool enabled;
  final TextEditingController controller;
  final void Function(Object?) onSubmit;
  final TimeOfDay? selectedTime;
  final List<BlockedBookingsModel> blockedBookings;
  final bool isDateLoaded;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      enableInteractiveSelection: false,
      validator: (val) {
        return nonEmptyValidator(val, errorMessage: 'Please select a date');
      },
      onTap: () {
        void onHandleDate(dynamic currentDate) {
          debugPrint("This is the booking ${blockedBookings.length}");

          // Check if selected date is within range of any of the blocked dates
          List<BlockedBookingsModel> tempList = blockedBookings.where((bk) => (bk.isBlocked ?? true) && bk.status != "Expired").toList();
          List<int> bookingsWithinRange = [];
          for (var booking in tempList) {
            bool isCurrentWithinRange = dateIsWithinRange(currentDate, booking.startDate, booking.endDate);
            if(isCurrentWithinRange){
              bookingsWithinRange.add(booking.bookingId ?? 0);
            }
          }
          
          if(!isDateLoaded){
            showInfo("Failed to select booking date");
          }else if(bookingsWithinRange.isNotEmpty){
            showInfo("Selected date is currently unavailable");
          }else{
            onSubmit(currentDate);
          }
        }

        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomDatePicker(
                isBooking: true,
                enablePastDates: false,
                minDate: DateTime.now(),
                onSumbit: (value) {
                  onHandleDate(value);
                },
              ),
            );
          },
        );
      },
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        hintText: 'Choose Date',
        contentPadding: const EdgeInsets.symmetric(
          vertical: kVerticalPadding,
          horizontal: 2,
        ),
        prefixIcon: Icon(
          Icons.calendar_today_outlined,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
