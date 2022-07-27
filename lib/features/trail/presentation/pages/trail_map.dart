// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';

class TrailMap extends StatelessWidget {
  const TrailMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TimberlandScaffold(
        extendBodyBehindAppbar: true,
        physics: const NeverScrollableScrollPhysics(),
        backButtonColor: Theme.of(context).backgroundColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: PhotoView(
            basePosition: const Alignment(.5, 0),
            initialScale: PhotoViewComputedScale.covered,
            maxScale: 1.0,
            minScale: .5,
            imageProvider: const AssetImage(
              'assets/images/trail-map.png',
            ),
          ),
        ),
      ),
    );
  }
}
