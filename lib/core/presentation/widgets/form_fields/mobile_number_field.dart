// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class MobileNumberField extends StatelessWidget {
  final TextInputAction? textInputAction;
  const MobileNumberField({
    Key? key,
    this.textInputAction,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExcludeFocus(
          child: SizedBox(
            width: 60,
            child: TextFormField(
              enabled: false,
              controller: TextEditingController(text: '+63'),
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: kVerticalPadding,
        ),
        Expanded(
          flex: 8,
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: '9** *** ****',
              counterText: '', // hide the counter text at the bottom
            ),
            validator: (number){
              if(number == null || number.isEmpty){
                return 'Field can not be empty';
              }
              if(number.length < 10){
                return 'Must be a 10 digit number';
              }
              if(!number.startsWith('9')){
                return "Should start with '9'";
              }
              return null;
            },
            maxLength: 10,
            keyboardType: TextInputType.phone,
            textInputAction: textInputAction,
          ),
        ),
      ],
    );
  }
}
