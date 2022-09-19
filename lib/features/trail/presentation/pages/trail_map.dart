// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/expanded_image.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/utils/device_storage/create_file_from_asset.dart';
import 'package:timberland_biketrail/features/trail/presentation/bloc/trail_bloc.dart';

class TrailMap extends StatelessWidget {
  const TrailMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<TrailBloc, TrailState>(
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
                  maxScale: .50,
                  minScale: .125,
                  imageProvider: const AssetImage(
                    'assets/images/trail-map.png',
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: kToolbarHeight, right: kVerticalPadding),
                    child: Hero(
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
                          height: 100,
                          width: 180,
                        ),
                      ),
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //         top: kToolbarHeight, left: kVerticalPadding),
                //     child: Image.asset(
                //       'assets/images/compass.png',
                //       height: 70,
                //       width: 70,
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: kToolbarHeight, left: kVerticalPadding),
                    child: Row(
                      children: [
                        // Image.asset(
                        //   'assets/images/trail-map-footer-2.png',
                        //   scale: 1.5,
                        // ),
                        // const SizedBox(
                        //   width: kVerticalPadding,
                        // ),
                        // Image.asset(
                        //   'assets/images/trail-map-footer-1.png',
                        //   scale: 1.5,
                        // ),
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
