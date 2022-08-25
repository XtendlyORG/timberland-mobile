// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/constants.dart';

class MobileNumberField extends StatelessWidget {
  final TextInputAction? textInputAction;
  final String? hintText;

  final bool allowEmpty;
  const MobileNumberField({
    Key? key,
    this.textInputAction,
    this.hintText,
    this.allowEmpty = false,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: ExcludeFocus(
            child: TextField(
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                hintText: '+63',
                hintStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: kVerticalPadding,
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText ?? '9** *** ****',
              counterText: '', // hide the counter text at the bottom
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (number) {
              if (number == null || number.isEmpty) {
                return allowEmpty
                    ? null
                    : 'Please enter your ${hintText?.toLowerCase()??'mobile number'}';
              }
              if (!number.startsWith('9')) {
                return "Should start with '9'";
              }
              if (number.length < 10) {
                return 'Must be a 10 digit number';
              }

              return null;
            },
            maxLength: 10,
            keyboardType: TextInputType.number,
            textInputAction: textInputAction,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ],
    );
  }
}
