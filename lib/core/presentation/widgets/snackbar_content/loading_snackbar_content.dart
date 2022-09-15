import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class LoadingSnackBarContent extends StatelessWidget {
  const LoadingSnackBarContent({
    Key? key,
    required this.loadingMessage,
  }) : super(key: key);
  final String loadingMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: 24,
          width: 24,
          child: RepaintBoundary(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
        const SizedBox(width: kVerticalPadding),
        Expanded(
          child: AutoSizeText(
            loadingMessage,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
