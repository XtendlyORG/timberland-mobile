import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/trail/trail_map_new/custom_map.dart';
import 'package:timberland_biketrail/features/trail/trail_map_new/tab_bar.dart';

import '../../../core/router/routes.dart';
import '../domain/entities/trail.dart';
import '../domain/params/fetch_trails.dart';
import '../presentation/bloc/trail_bloc.dart';
import 'tab_contents/additional_info.dart';
import 'tab_contents/trail_directory.dart';
import 'tab_contents/trail_progression.dart';

class CustomMapPage extends StatefulWidget {
  const CustomMapPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomMapPage> createState() => _CustomMapPageState();
}

class _CustomMapPageState extends State<CustomMapPage> {
  int _currentIndex = 0;
  String selectedTrail = '';
  late TransformationController _controller;

  @override
  void initState() {
    _controller = TransformationController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void selectTrail(String trail) {
      setState(() {
        selectedTrail = trail;
      });
    }

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
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: selectedTrail.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 40,
                            child: FilledTextButton(
                              onPressed: () {
                                List<Trail> trailList = state.trails
                                    .where((e) =>
                                        e.trailName.toString().toLowerCase() ==
                                        selectedTrail.toLowerCase())
                                    .toList();
                                if (trailList.isNotEmpty) {
                                  Trail trail = trailList[0];
                                  context.pushNamed(
                                    Routes.specificTrail.name,
                                    params: {
                                      'id': trail.trailId,
                                    },
                                    extra: trail,
                                  );
                                } else {
                                  showToast("Trail not found");
                                }
                              },
                              child: Text(
                                'View $selectedTrail',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox()),
            body: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                ),
                CustomMap(
                  controller: _controller,
                ),
                Positioned(
                  bottom: 20,
                  child: SizedBox(
                    height: 410,
                    child: Column(
                      children: [
                        MapTabBar(
                          currentIndex: _currentIndex,
                          onTap: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        Expanded(
                          child: IndexedStack(
                            index: _currentIndex,
                            children: [
                              TrailDirectory(
                                controller: _controller,
                                selectTrail: selectTrail,
                              ),
                              const TrailProgression(),
                              AdditionalInfo(
                                selectedTrail: selectedTrail,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
