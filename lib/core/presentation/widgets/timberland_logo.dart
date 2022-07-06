// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TimberlandLogo extends StatelessWidget {
  final Color? titleColor;
  final Color? iconColor;
  const TimberlandLogo({
    Key? key,
    this.titleColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: const AssetImage('assets/icons/logo-icon.png'),
          height: 32,
          color: iconColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Image(
            image: const AssetImage('assets/icons/logo-title.png'),
            height: 16,
            color: titleColor ?? const Color(0xff323E48),
          ),
        ),
        Image(
          image: const AssetImage('assets/icons/logo-subtitle.png'),
          height: 8,
          color: titleColor ?? const Color(0xff323E48),
        ),
      ],
    );
  }
}
