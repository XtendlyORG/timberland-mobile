// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

class OTPResendButton extends StatefulWidget {
  const OTPResendButton({
    Key? key,
    required this.duration,
  }) : super(key: key);

  final int duration;

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
    final authState = BlocProvider.of<AuthBloc>(context).state;
    return canResend
        ? SizedBox.shrink(
            child: Center(
              child: InkWell(
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    SendOtpEvent(
                        registerParameter:
                            (authState as OtpSent).registerParameter),
                  );
                  startTimer(duration: widget.duration);
                },
                child: Text(
                  'Resend OTP',
                  style: Theme.of(context).textTheme.button?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              'Resend in: ${widget.duration - _timer!.tick}',
              style: Theme.of(context).textTheme.button?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color),
            ),
          );
  }
}
