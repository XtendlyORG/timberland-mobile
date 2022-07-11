// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final double size;
  final String? assetImagePath;
  final Widget? icon;
  final VoidCallback onTap;
  final Color? color;
  const CircularIconButton({
    Key? key,
    this.size = 36,
    this.assetImagePath,
    this.icon,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        height: size,
        width: size,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? Theme.of(context).primaryColor,
        ),
        alignment: Alignment.center,
        child: assetImagePath != null
            ? Image(
                image: AssetImage(assetImagePath!),
                height: size / 2,
                width: size / 2,
              )
            : icon!,
      ),
    );
  }
}
