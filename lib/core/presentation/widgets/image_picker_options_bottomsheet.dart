import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class ImagePickerOptionBottomSheet extends StatelessWidget {
  final VoidCallback fromCameraCallback;
  final VoidCallback fromGalleryCallback;
  const ImagePickerOptionBottomSheet({
    Key? key,
    required this.fromCameraCallback,
    required this.fromGalleryCallback,
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
                  child: CustomTextButton(
                    onTap: fromCameraCallback,
                    child: const Text("Take a Photo"),
                  ),
                ),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomTextButton(
                    onTap: fromGalleryCallback,
                    child: const Text("Choose from Gallery"),
                  ),
                ),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
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

class CustomTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const CustomTextButton({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            style: BorderStyle.solid,
            width: 2,
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: child,
      ),
    );
  }
}
