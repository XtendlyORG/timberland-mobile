// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/presentation/widgets/expanded_image.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    required this.imgUrl,
    required this.radius,
    this.useAssetImage = false,
  }) : super(key: key);

  final String imgUrl;
  final double radius;
  final bool useAssetImage;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: radius.toString(),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ExpandedImage(
                  imageProvider: buildImage(),
                  tag: radius.toString(),
                );
              },
            ),
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: TimberlandColor.text.withOpacity(.3),
                blurRadius: 2.5,
                spreadRadius: 2.5,
              )
            ],
          ),
          child: CircleAvatar(
            radius: radius,
            foregroundImage: buildImage(),
          ),
        ),
      ),
    );
  }

  ImageProvider buildImage() {
    if (useAssetImage) {
      return Image.file(File(imgUrl)).image;
    }
    return CachedNetworkImageProvider(imgUrl);
  }
}
