// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ExpandedImage extends StatelessWidget {
  const ExpandedImage({
    Key? key,
    this.useAssetImage = false,
    required this.tag,
    required this.imgUrl,
  }) : super(key: key);
  final bool useAssetImage;
  final String tag;
  final String imgUrl;

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
                  imageProvider: buildImage(),
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

  ImageProvider buildImage() {
    if (useAssetImage) {
      return AssetImage(imgUrl);
    }
    return CachedNetworkImageProvider(imgUrl);
  }
}
