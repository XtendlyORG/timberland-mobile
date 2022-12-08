// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OTPResendButton extends StatefulWidget {
  const OTPResendButton({
    Key? key,
    required this.duration,
    required this.onTap,
  }) : super(key: key);

  final int duration;
  final VoidCallback onTap;

  @override
  State<OTPResendButton> createState() => _OTPResendButtonState();
}

class _OTPResendButtonState extends State<OTPResendButton> {
  bool canResend = true;

  Timer? _timer;
  startTimer({int duration = 10}) {
    canResend = false;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_timer!.tick < duration) {
          setState(() {});
        } else {
          setState(() {
            canResend = true;
            timer.cancel();
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: "Didn't receive the code? ",
          ),
          canResend
              ? TextSpan(
                  text: 'Resend OTP',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      widget.onTap();
                      startTimer(duration: widget.duration);
                    },
                )
              : TextSpan(
                  text: 'Resend in: ${widget.duration - _timer!.tick}',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
        ],
      ),
      style: Theme.of(context).textTheme.titleSmall,
      maxLines: 1,
    );
  }
}
