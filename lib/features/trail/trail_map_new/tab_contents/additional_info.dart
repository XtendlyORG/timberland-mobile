import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/themes/timberland_color.dart';
import '../../domain/entities/trail.dart';
import '../../domain/params/fetch_trails.dart';
import '../../presentation/bloc/trail_bloc.dart';

class AdditionalInfo extends StatelessWidget {
  final String selectedTrail;
  const AdditionalInfo({super.key, required this.selectedTrail});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrailBloc, TrailState>(
      buildWhen: (previous, current) {
        return current is! TrailMapState;
      },
      builder: (context, state) {
        if (state is TrailInitial) {
          BlocProvider.of<TrailBloc>(context)
              .add(FetchTrailsEvent(fetchTrailsParams: FetchTrailsParams()));
        }
        if (state is LoadingTrails) {
          return SizedBox(
            height: MediaQuery.of(context).size.height -
                kToolbarHeight * 2 -
                kBottomNavigationBarHeight,
            child: const RepaintBoundary(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        }
        if (state is TrailsLoaded) {
          return Center(
            child: Container(
                height: 500,
                color: TimberlandColor.background,
                width: MediaQuery.of(context).size.width * 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //info 1
                          Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Center(
                                  child: Image.asset(
                                    'assets/trail_map/arrowsWhite.png',
                                    width: 50,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: const Text(
                                    'Directional arrows. Trails are one way unless specified.'),
                              )
                            ],
                          ),
                          //info 2
                          Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Center(
                                  child: Image.asset(
                                    'assets/trail_map/greenDots.png',
                                    width: 50,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: const Text(
                                    'Green dots indicate the recommended route for first-time visitors to TMBP.'),
                              )
                            ],
                          ),
                          //info 3
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Center(
                                  child: Image.asset(
                                    'assets/trail_map/yellowCircleIcon.png',
                                    width: 50,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: const Text(
                                    'Wayfinders contain directional information and also indicate when trails merge or branch out.'),
                              )
                            ],
                          ),
                          //info 4
                          Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Center(
                                  child: Image.asset(
                                    'assets/trail_map/CameraIcons.png',
                                    width: 50,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: const Text(
                                    'Points of interest, rest stops & designated photo spots. These locations also contain airhorns for emergency signalling'),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //Redirect Button
                          selectedTrail == ''
                              ? SizedBox()
                              : InkWell(
                                  onTap: () {
                                    List<Trail> trailList = state.trails
                                        .where((e) =>
                                            e.trailName
                                                .toString()
                                                .toLowerCase() ==
                                            selectedTrail.toLowerCase())
                                        .toList();
                                    Trail trail = trailList[0];
                                    context.pushNamed(
                                      Routes.specificTrail.name,
                                      params: {
                                        'id': trail.trailId,
                                      },
                                      extra: trail,
                                    );
                                  },
                                  child: Card(
                                    color: Colors.transparent,
                                    elevation: 20,
                                    child: Container(
                                      width: 200,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: TimberlandColor.primary,
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          'View $selectedTrail',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ]),
                  ),
                )),
          );
        }
        if (state is TrailError) {
          return SizedBox(
            height: MediaQuery.of(context).size.height -
                kToolbarHeight * 2 -
                kBottomNavigationBarHeight,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(state.message),
                ],
              ),
            ),
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight * 2 -
              kBottomNavigationBarHeight,
          child: const Center(
            child: Text("Error Occured"),
          ),
        );
      },
    );
  }
}
