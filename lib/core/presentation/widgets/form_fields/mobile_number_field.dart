import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';

class MobileNumberField extends StatelessWidget {
  const MobileNumberField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
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
            maxLength: 10,
            keyboardType: TextInputType.phone,
          ),
        ),
      ],
    );
  }
}
