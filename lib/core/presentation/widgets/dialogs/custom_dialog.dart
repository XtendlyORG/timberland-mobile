import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.content,
    this.alignment,
  }) : super(key: key);
  final Widget content;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: alignment,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      contentPadding: EdgeInsets.zero,
      content: content,
    );
  }
}
