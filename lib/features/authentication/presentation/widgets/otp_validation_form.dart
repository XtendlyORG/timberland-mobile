// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/otp_resend_button.dart';

class OtpVerificationForm extends StatefulWidget {
  const OtpVerificationForm({
    Key? key,
    required this.onSubmit,
    required this.onResend,
  }) : super(key: key);

  final void Function(String otp) onSubmit;
  final VoidCallback onResend;

  @override
  State<OtpVerificationForm> createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  late bool validOtp;
  late final TextEditingController otpCtrl;
  late final TextEditingController digit1;
  late final TextEditingController digit2;
  late final TextEditingController digit3;
  late final TextEditingController digit4;
  @override
  void initState() {
    super.initState();
    validOtp = false;

    otpCtrl = TextEditingController();
    digit1 = TextEditingController();
    digit2 = TextEditingController();
    digit3 = TextEditingController();
    digit4 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kHorizontalPadding),
          child: Text(
            'OTP Verification',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kHorizontalPadding),
          child: AutoSizeText(
            'Enter the verification code we just sent you on your email address.',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kVerticalPadding),
          child: Form(
            onChanged: () {
              otpCtrl.text =
                  digit1.text + digit2.text + digit3.text + digit4.text;
              if (otpCtrl.text.length != 4 && validOtp) {
                setState(() {
                  validOtp = false;
                });
              }
              if (otpCtrl.text.length == 4 && !validOtp) {
                setState(() {
                  validOtp = true;
                });
              }
            },
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: digit1,
                    maxLength: 1,
                    onChanged: (val) {
                      if (val.length == 1) {
                        FocusManager.instance.primaryFocus?.nextFocus();
                      }
                    },
                    onEditingComplete: (){},
                    decoration: const InputDecoration(counterText: ''),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: digit2,
                    maxLength: 1,
                    onChanged: (val) {
                      if (val.length == 1) {
                        FocusManager.instance.primaryFocus?.nextFocus();
                      } else {
                        FocusManager.instance.primaryFocus?.previousFocus();
                      }
                    },
                    onEditingComplete: (){},
                    decoration: const InputDecoration(counterText: ''),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: digit3,
                    maxLength: 1,
                    onChanged: (val) {
                      if (val.length == 1) {
                        FocusManager.instance.primaryFocus?.nextFocus();
                      } else {
                        FocusManager.instance.primaryFocus?.previousFocus();
                      }
                    },
                    onEditingComplete: (){},
                    decoration: const InputDecoration(counterText: ''),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    autofocus: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: digit4,
                    maxLength: 1,
                    onChanged: (val) {
                      if (val.isEmpty) {
                        FocusManager.instance.primaryFocus?.previousFocus();
                      }
                    },
                    onFieldSubmitted: (_) {
                      validOtp ? widget.onSubmit(otpCtrl.text) : null;
                    },
                    onEditingComplete: (){},
                    onSaved: (_){},
                    decoration: const InputDecoration(counterText: ''),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    autofocus: true,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kVerticalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                "Didn’t receive the code?",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                width: 100,
                height: 40,
                child: OTPResendButton(
                  duration: 10,
                  onTap: widget.onResend,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: FilledTextButton(
            onPressed: validOtp
                ? () {
                    widget.onSubmit(otpCtrl.text);
                  }
                : null,
            child: const Text("Validate OTP"),
          ),
        ),
      ],
    );
  }
}
