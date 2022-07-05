import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final double size;
  final String assetImagePath;
  final VoidCallback onTap;
  const CircularIconButton({
    Key? key,
    this.size = 36,
    required this.assetImagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: TextButton(
        onPressed: onTap,
        child: Image(
          image: AssetImage(assetImagePath),
          height: size,
          width: size,
        ),
      ),
    );
  }
}
