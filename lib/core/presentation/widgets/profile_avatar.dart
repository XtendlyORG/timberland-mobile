// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:timberland_biketrail/core/presentation/widgets/expanded_image.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    required this.imgUrl,
    required this.radius,
  }) : super(key: key);

  final String imgUrl;
  final double radius;

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
                  imgUrl: imgUrl,
                  tag: radius.toString(),
                );
              },
            ),
          );
        },
        child: CircleAvatar(
          radius: radius,
          foregroundImage: CachedNetworkImageProvider(
            imgUrl,
          ),
        ),
      ),
    );
  }
}
