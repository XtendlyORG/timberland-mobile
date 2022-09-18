
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/date_picker.dart';
import '../../../../core/utils/validators/non_empty_validator.dart';

class BookingDatePicker extends StatelessWidget {
  const BookingDatePicker({
    Key? key,
    this.enabled = false,
    required this.controller,
    required this.onSubmit,
  }) : super(key: key);

  final bool enabled;
  final TextEditingController controller;
  final void Function(Object?) onSubmit;

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

        if (TimeOfDay.now().hour > 14 ||
            (TimeOfDay.now().hour == 14 && TimeOfDay.now().minute > 30)) {
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
        prefixIcon: Icon(
          Icons.calendar_today_outlined,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
