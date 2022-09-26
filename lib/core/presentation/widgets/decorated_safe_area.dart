// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class DecoratedSafeArea extends StatelessWidget {
  final Widget child;
  const DecoratedSafeArea({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: TimberlandColor.primary,
      ),
      child: SafeArea(
        child: child,
      ),
    );
  }
}
