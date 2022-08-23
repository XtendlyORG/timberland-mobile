// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class LockUserWidget extends StatefulWidget {
  const LockUserWidget({
    Key? key,
    required this.duration,
    required this.onFinishTimer,
  }) : super(key: key);
  final int duration;
  final VoidCallback onFinishTimer;

  @override
  State<LockUserWidget> createState() => _LockUserWidgetState();
}

class _LockUserWidgetState extends State<LockUserWidget> {
  String? timerCount;
  Timer? _timer;

  startTimer({int duration = 30, required BuildContext context}) {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_timer!.tick < duration) {
          setState(() {
            timerCount = (duration - _timer!.tick).toString();
          });
        } else {
          widget.onFinishTimer();
          setState(() {
            timer.cancel();
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer(
      duration: widget.duration,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: BoxDecoration(gradient: TimberlandColor.linearGradient),
        constraints: const BoxConstraints(maxHeight: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColor,
                size: 48,
              ),
            ),
            Expanded(
              child: AutoSizeText(
                'Try again in: ${widget.duration - _timer!.tick} seconds',
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
