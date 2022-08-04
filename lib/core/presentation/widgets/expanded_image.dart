// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ExpandedImage extends StatelessWidget {
  const ExpandedImage({
    Key? key,
    required this.imageProvider,
    required this.tag,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.black,
        child: Hero(
          tag: tag,
          child: Stack(
            children: [
              Expanded(
                child: PhotoView(
                  initialScale: PhotoViewComputedScale.contained,
                  maxScale: 1.5,
                  minScale: PhotoViewComputedScale.contained,
                  imageProvider: imageProvider,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: BackButton(
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
