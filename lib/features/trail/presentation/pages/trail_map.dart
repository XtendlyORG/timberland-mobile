// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/expanded_image.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/core/utils/device_storage/create_file_from_asset.dart';
import 'package:timberland_biketrail/features/trail/presentation/bloc/trail_bloc.dart';

class TrailMap extends StatelessWidget {
  const TrailMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrailBloc, TrailState>(
      listener: (context, state) {
        if (state is SavingTrailMap) {
          showToast("Saving trail map image...");
        }
        if (state is TrailMapSaved) {
          showSuccess('Image saved to ${state.path}');
        }
        if (state is TrailMapSaveError) {
          showToast(state.errorMessage);
        }
      },
      child: DecoratedSafeArea(
        child: TimberlandScaffold(
          extendBodyBehindAppbar: true,
          physics: const NeverScrollableScrollPhysics(),
          backButtonColor: Theme.of(context).backgroundColor,
          body: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: Stack(
              children: [
                PhotoView(
                  basePosition: const Alignment(.5, 0),
                  initialScale: PhotoViewComputedScale.covered,
                  maxScale: 2.0,
                  minScale: PhotoViewComputedScale.covered,
                  imageProvider: const AssetImage(
                    'assets/images/trail-map.png',
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: kToolbarHeight, right: kVerticalPadding),
                    child: ExpandableWidget(
                      alignment: Alignment.topCenter,
                      minimizedWidget: Image.asset(
                        'assets/icons/trail-map-minimized-readme.png',
                      ),
                      child: Hero(
                        tag: 'trail-map-readme',
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) {
                                  return const ExpandedImage(
                                    imageProvider: AssetImage(
                                      'assets/images/trail-map-readme.png',
                                    ),
                                    tag: 'trail-map-readme',
                                  );
                                },
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/trail-map-readme.png',
                            height: 150,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: kToolbarHeight, left: kVerticalPadding),
                    child: Image.asset(
                      'assets/images/compass.png',
                      height: 70,
                      width: 70,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: kToolbarHeight, left: kVerticalPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ExpandableWidget(
                          alignment: Alignment.bottomCenter,
                          minimizedWidget: Image.asset(
                            'assets/icons/trail-map-minimized-legends.png',
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Hero(
                                tag: 'trail-map-legends',
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) {
                                          return const ExpandedImage(
                                            imageProvider: AssetImage(
                                              'assets/images/trail-map-legends.png',
                                            ),
                                            tag: 'trail-map-legends',
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/trail-map-legends.png',
                                    scale: 3.5,
                                  ),
                                ),
                              ),
                              Hero(
                                tag: 'trail-map-symbols',
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) {
                                          return const ExpandedImage(
                                            imageProvider: AssetImage(
                                              'assets/images/trail-map-symbols.png',
                                            ),
                                            tag: 'trail-map-symbols',
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/trail-map-symbols.png',
                                    scale: 3.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            BlocProvider.of<TrailBloc>(context).add(
                              SaveTrailMapEvent(
                                imageFile: await createFileFromAsset(
                                  'assets/images/trail-map.png',
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.download,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                      ],
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

class ExpandableWidget extends StatefulWidget {
  const ExpandableWidget({
    Key? key,
    required this.child,
    required this.minimizedWidget,
    required this.alignment,
  }) : super(key: key);

  final Widget child;
  final Widget minimizedWidget;

  final AlignmentGeometry alignment;

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool isMinimized = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          alignment: widget.alignment == Alignment.bottomCenter
              ? Alignment.bottomLeft
              : Alignment.topRight,
          child: child,
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: widget.alignment == Alignment.bottomCenter
              ? Alignment.bottomLeft
              : Alignment.topRight,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      child: isMinimized
          ? GestureDetector(
              onTap: () {
                setState(() {
                  isMinimized = false;
                });
              },
              child: SizedBox.square(
                dimension: 24,
                child: widget.minimizedWidget,
              ),
            )
          : Stack(
              alignment: Alignment.topRight,
              children: [
                widget.child,
                Container(
                  color: Colors.black.withOpacity(.5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMinimized = true;
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: TimberlandColor.background,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
