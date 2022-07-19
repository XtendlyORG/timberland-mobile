// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/outlined_text_button.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class ImagePickerOptionBottomSheet extends StatelessWidget {
  final void Function({required ImageSource source}) callback;

  const ImagePickerOptionBottomSheet({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            gradient: TimberlandColor.linearGradient,
          ),
          constraints: const BoxConstraints(maxHeight: 300),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: OutlinedTextButton(
                    onPressed: () {
                      callback(source: ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Take a Photo",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedTextButton(
                    onPressed: () {
                      callback(source: ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Choose from Gallery",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledTextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).backgroundColor,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
