import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.passwordCtrl,
  }) : super(key: key);

  final TextEditingController passwordCtrl;

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
      controller: widget.passwordCtrl,
      obscureText: hidePassword,
      validator: (password) {
        if (password == null || password.isEmpty) {
          return 'Password cannot be empty';
        }
      },
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
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
    );
  }
}
