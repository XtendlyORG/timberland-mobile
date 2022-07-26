
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/date_picker.dart';

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
      style: Theme.of(context).textTheme.bodyText1,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomDatePicker(
                enablePastDates: false,
                minDate: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day + 3,
                ),
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
