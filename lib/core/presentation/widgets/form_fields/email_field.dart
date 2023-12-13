// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../../utils/validators/email_validator.dart';

class EmailField extends StatelessWidget {
  final TextInputAction? textInputAction;
  final String? hintText;
  final bool? enabled;
  const EmailField({
    Key? key,
    this.textInputAction,
    this.hintText,
    required this.controller,
    this.label,
    this.enabled,
  }) : super(key: key);

  final TextEditingController controller;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validateEmail,
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: label != null ? null : hintText ?? 'Email Address',
        label: label,
      ),
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
