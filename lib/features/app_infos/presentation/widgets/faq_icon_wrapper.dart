import 'package:flutter/material.dart';

class FaqIconWrapper extends StatelessWidget {
  final Widget icon;
  final BoxShape shape;
  const FaqIconWrapper({
    Key? key,
    required this.icon,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
        shape: shape,
      ),
      child: icon,
    );
  }
}
