import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class AuthLockedWidget extends StatefulWidget {
  const AuthLockedWidget({
    super.key,
    required this.duration,
  });
  final int duration;

  @override
  State<AuthLockedWidget> createState() => _AuthLockedWidgetState();
}

class _AuthLockedWidgetState extends State<AuthLockedWidget> {
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
          BlocProvider.of<AuthBloc>(context).add(
            const UnlockAuthEvent(),
          );
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
    return ConstrainedBox(
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
    );
  }
}
