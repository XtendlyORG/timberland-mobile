// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
                return ProfilePicture(
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

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
    required this.tag,
    required this.imgUrl,
  }) : super(key: key);
  final String tag;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag: tag,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: PhotoView(
            initialScale: PhotoViewComputedScale.contained,
            maxScale: 1.5,
            minScale: PhotoViewComputedScale.contained,
            imageProvider: CachedNetworkImageProvider(
              imgUrl,
            ),
          ),
        ),
      ),
    );
  }
}
