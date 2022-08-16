// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FilledTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  const FilledTextButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: style ??
          TextButton.styleFrom(
            backgroundColor: onPressed!=null?Theme.of(context).primaryColor:Theme.of(context).disabledColor,
            primary: Theme.of(context).backgroundColor,
          ),
      child: child,
    );
  }
}
