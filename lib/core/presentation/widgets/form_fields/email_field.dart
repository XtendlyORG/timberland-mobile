// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../../utils/validators/email_validator.dart';

class EmailField extends StatelessWidget {
  final TextInputAction? textInputAction;
  const EmailField({
    Key? key,
    this.textInputAction,
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
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
