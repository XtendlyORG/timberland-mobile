// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

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
    return canResend
        ? SizedBox.shrink(
            child: Center(
              child: InkWell(
                onTap: () {
                  widget.onTap();
                  startTimer(duration: widget.duration);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Resend OTP',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Resend in: ${widget.duration - _timer!.tick}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
          );
  }
}
