// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';

import '../../../../core/presentation/widgets/date_picker.dart';
import '../../../../core/utils/validators/non_empty_validator.dart';

class BookingDatePicker extends StatelessWidget {
  const BookingDatePicker({
    Key? key,
    this.enabled = false,
    required this.controller,
    required this.onSubmit,
    this.selectedTime,
  }) : super(key: key);

  final bool enabled;
  final TextEditingController controller;
  final void Function(Object?) onSubmit;
  final TimeOfDay? selectedTime;

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
        DateTime? minDate;

        bool isPast230Pm = TimeOfDay.now().hour > 14 ||
            (TimeOfDay.now().hour == 14 && TimeOfDay.now().minute > 30);

        bool currentTimeIsPastSelectedTime = (selectedTime != null &&
            (selectedTime!.hour < TimeOfDay.now().hour ||
                (selectedTime!.hour == TimeOfDay.now().hour &&
                    selectedTime!.minute < TimeOfDay.now().minute)));

        if (isPast230Pm || currentTimeIsPastSelectedTime) {
          minDate = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day + 1,
          );
        }

        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomDatePicker(
                enablePastDates: false,
                minDate: minDate,
                onSumbit: onSubmit,
              ),
            );
          },
        );
      },
      decoration: InputDecoration(
        hintText: 'Choose Date',
        contentPadding: const EdgeInsets.symmetric(vertical: kVerticalPadding,horizontal: 2),
        prefixIcon: Icon(
          Icons.calendar_today_outlined,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
