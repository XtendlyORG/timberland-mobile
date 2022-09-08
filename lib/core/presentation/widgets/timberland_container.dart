// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TimberlandContainer extends StatelessWidget {
  final Alignment alignment;
  final Widget child;
  const TimberlandContainer({
    Key? key,
    this.alignment = Alignment.center,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.topRight,
          child: Image(
            image: AssetImage('assets/images/top-right-frame.png'),
            width: 130,
          ),
        ),
        Align(
          alignment: alignment,
          child: child,
        ),
      ],
    );
  }
}
