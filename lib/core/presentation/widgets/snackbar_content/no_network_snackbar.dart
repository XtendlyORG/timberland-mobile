import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';

SnackBar get noNetworkSnackBar => SnackBar(
      duration: const Duration(days: 1),
      dismissDirection: DismissDirection.none,
      content: const AutoSizeText(
        'No internet connection',
        textAlign: TextAlign.center,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.only(
        right: 20,
        left: 20,
        bottom: kHorizontalPadding,
      ),
    );
