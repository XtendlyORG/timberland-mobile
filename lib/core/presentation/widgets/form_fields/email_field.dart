
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/utils/validators/email_validator.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validateEmail,
      decoration: const InputDecoration(
        hintText: 'Email Address',
      ),
    );
  }
}
