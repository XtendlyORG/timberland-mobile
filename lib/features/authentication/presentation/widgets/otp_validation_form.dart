import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/otp_resend_button.dart';

class OtpVerificationForm extends StatelessWidget {
  const OtpVerificationForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final void Function(String otp) onSubmit;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final otpCtrl = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kToolbarHeight),
          child: Text(
            'OTP Verification',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kVerticalPadding),
          child: Form(
            key: formKey,
            child: TextFormField(
              controller: otpCtrl,
              maxLength: 6,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'OTP can not be empty.';
                } else if (val.length != 6 || int.tryParse(val) == null) {
                  return 'OTP must be a 6 digit number.';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter your OTP',
                suffixIcon: SizedBox(
                  width: 100,
                  child: OTPResendButton(
                    duration: 10,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              autofocus: true,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: FilledTextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSubmit(otpCtrl.text);
              }
            },
            child: const Text("Validate OTP"),
          ),
        ),
      ],
    );
  }
}
