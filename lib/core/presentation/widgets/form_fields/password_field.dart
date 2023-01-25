// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/utils/validators/validators.dart';

class PasswordField extends StatefulWidget {
  final TextInputAction? textInputAction;
  const PasswordField({
    Key? key,
    this.textInputAction,
    this.hintText = '*Password',
    required this.controller,
    this.acceptEmpty = false,
    this.validator,
    this.label,
  }) : super(key: key);
  final String hintText;
  final TextEditingController controller;
  final bool acceptEmpty;
  final String? Function(String?)? validator;
  final Widget? label;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late bool hidePassword;
  @override
  void initState() {
    super.initState();
    hidePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: hidePassword,
      validator: widget.validator ??
          (password) {
            return passwordValidator(password, acceptEmpty: widget.acceptEmpty);
          },
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: widget.label != null ? null : widget.hintText,
        label: widget.label,
        errorMaxLines: 5,
        suffixIcon: ExcludeFocus(
          child: IconButton(
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            icon: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
      ),
    );
  }
}
