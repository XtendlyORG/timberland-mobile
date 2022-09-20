import 'package:flutter/material.dart';

class CustomStyledText extends StatelessWidget {
  const CustomStyledText({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final texts = text.split('<bold>');

    return Text.rich(
      style: style,
      TextSpan(
        children: texts.map((text) {
          final textWithBold = text.split('</bold>');
          if (textWithBold.length > 1) {
            return TextSpan(
              children: [
                TextSpan(
                  text: textWithBold[0],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: textWithBold[1],
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            );
          }
          return TextSpan(text: text);
        }).toList(),
      ),
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
