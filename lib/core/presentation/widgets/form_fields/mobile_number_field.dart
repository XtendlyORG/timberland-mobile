// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

import '../../../constants/constants.dart';

class MobileNumberField extends StatefulWidget {
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
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  bool hasValidator = false;
  String errorMsg = "";
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    bool numberValidator(String number) {
      // if (number == null || number.isEmpty) {
      //   setState(() {
      //     hasValidator = true;
      //     errorMsg =
      //         'Please enter your ${widget.hintText?.toLowerCase() ?? 'mobile number'}';
      //   });
      //   return hasValidator;
      // }

      if (!number.startsWith('9')) {
        setState(() {
          hasValidator = true;
          errorMsg = "Should start with '9'";
        });
        return hasValidator;
        // return "Should start with '9'";
      }
      if (number.length < 10) {
        setState(() {
          hasValidator = true;
          errorMsg = "Must be a 10 digit number";
        });
        return hasValidator;
        // return 'Must be a 10 digit number';
      }
      setState(() {
        hasValidator = false;
      });
      print('valid');
      errorMsg = "";
      return hasValidator;
    }

    return Column(
      children: [
        Row(
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
                validator: (value) {
                  if (!value!.startsWith('9')) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      hasValidator = true;
                      errorMsg = "Should start with '9'";
                      setState(() {});
                    });
                    return '';
                  }
                  if (value.length < 10) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      hasValidator = true;
                      errorMsg = "Must be a 10 digit number";
                      setState(() {});
                    });

                    return '';
                  }
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    hasValidator = false;
                    errorMsg = "";
                    setState(() {});
                  });

                  return null;
                },
                controller: widget.controller,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(
                    height: 0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: errorMsg.isNotEmpty ? Colors.red : TimberlandColor.primary,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: errorMsg.isNotEmpty ? Colors.red : TimberlandColor.primary,
                      width: 1.0,
                    ),
                  ),
                  hintText: widget.hintText ?? '9** *** ****',
                  counterText: '', // hide the counter text at the bottom
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 10,
                keyboardType: TextInputType.number,
                textInputAction: widget.textInputAction,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const SizedBox(
              width: 60,
            ),
            const SizedBox(
              width: kVerticalPadding,
            ),
            hasValidator
                ? Text(
                    errorMsg,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
