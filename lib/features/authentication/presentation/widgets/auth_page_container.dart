// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AuthPageContainer extends StatelessWidget {
  final Widget child;
  final Alignment alignment;
  const AuthPageContainer({
    Key? key,
    required this.child,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.topRight,
          child: Image(
            image: AssetImage('assets/images/top-right-frame.png'),
            width: 150,
          ),
        ),
        Align(
          alignment: alignment,
          child: child,
        ),
        const Align(
          alignment: Alignment.bottomLeft,
          child: Image(
            image: AssetImage('assets/images/bottom-left-frame.png'),
            width: 150,
          ),
        ),
      ],
    );
  }
}
