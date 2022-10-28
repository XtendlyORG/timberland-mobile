// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_checkbox.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/expanded_image.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
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
    ImageController smartCtrl = ImageController(name: 'S.M.A.R.T.');
    ImageController legendsCtrl = ImageController(name: 'Legends');
    ImageController symbolsCtrl = ImageController(name: 'Symbols');

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
                      tag: 'trail-map-readme',
                      imageToShow: Image.asset(
                        'assets/images/trail-map-readme.png',
                        width: 100,
                      ),
                      onCreate: (ctrl) {
                        smartCtrl.status = ctrl;
                      },
                      onFullScreen: () {
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
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ExpandableWidget(
                              tag: 'trail-map-legends',
                              imageToShow: Image.asset(
                                'assets/images/trail-map-legends.png',
                                scale: 3.5,
                              ),
                              onCreate: (ctrl) {
                                legendsCtrl.status = ctrl;
                              },
                              onFullScreen: () {
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
                            ),
                            ExpandableWidget(
                              tag: 'trail-map-symbols',
                              imageToShow: Image.asset(
                                'assets/images/trail-map-symbols.png',
                                scale: 3.5,
                              ),
                              onFullScreen: () {
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
                              onCreate: (ctrl) {
                                symbolsCtrl.status = ctrl;
                              },
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              // barrierColor: Colors.transparent,
                              clipBehavior: Clip.hardEdge,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: kHorizontalPadding,
                                    vertical: kVerticalPadding,
                                  ),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ...[
                                          smartCtrl,
                                          legendsCtrl,
                                          symbolsCtrl,
                                        ]
                                            .map(
                                              (e) => CustomCheckbox(
                                                initValue: e.status?.status ==
                                                    AnimationStatus.completed,
                                                onChange: (val) {
                                                  if (val) {
                                                    e.show();
                                                    return;
                                                  }
                                                  e.hide();
                                                },
                                                child: Text(
                                                  e.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        const SizedBox(
                                          height: kVerticalPadding,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: FilledTextButton(
                                            child: const Text("DONE"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ),
                                      ]),
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.settings,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
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

class ImageController {
  AnimationController? status;
  final String name;
  ImageController({
    this.status,
    required this.name,
  });

  void show() => status?.forward();
  void hide() => status?.reverse();
}

class ExpandableWidget extends StatefulWidget {
  const ExpandableWidget({
    Key? key,
    required this.tag,
    required this.imageToShow,
    required this.onFullScreen,
    required this.onCreate,
  }) : super(key: key);

  final String tag;
  final Image imageToShow;
  final VoidCallback onFullScreen;
  final void Function(AnimationController ctrl) onCreate;

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  bool imageVisible = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    widget.onCreate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      alignment: Alignment.topCenter,
      scaleY: controller.value,
      child: Hero(
        tag: widget.tag,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
                color: Colors.black.withOpacity(.4),
              ),
              child: widget.imageToShow,
            ),
            GestureDetector(
              onTap: () {
                widget.onFullScreen();
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: TimberlandColor.background.withOpacity(.8),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.fullscreen_rounded,
                  size: 48,
                  color: TimberlandColor.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
