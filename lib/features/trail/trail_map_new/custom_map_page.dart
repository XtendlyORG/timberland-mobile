import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/features/trail/trail_map_new/custom_map.dart';
import 'package:timberland_biketrail/features/trail/trail_map_new/tab_bar.dart';

import '../../../core/presentation/widgets/state_indicators/state_indicators.dart';
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

class _CustomMapPageState extends State<CustomMapPage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  String selectedTrail = '';
  late TransformationController _controller;

  late final AnimationController _pulseController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat();
  late final Animation<double> _scaleAnimation = Tween<double>(begin: 0.6, end: 1.2).animate(_pulseController);
  late final Animation<double> _fadeAnimation = Tween<double>(begin: 1, end: 0.2).animate(_pulseController);

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
          BlocProvider.of<TrailBloc>(context).add(FetchTrailsEvent(fetchTrailsParams: FetchTrailsParams()));
        }
        if (state is LoadingTrails) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight * 2 - kBottomNavigationBarHeight,
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
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: ScaleTransition(
                                  scale: _scaleAnimation,
                                  child: Container(
                                    width: 32.5 * 1.5,
                                    height: 32.5 * 1.5,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.shade300),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  List<Trail> trailList =
                                      state.trails.where((e) => e.trailName.toString().toLowerCase() == selectedTrail.toLowerCase()).toList();
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
                                child: Icon(
                                  Icons.info_outlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 32.5,
                                ),
                              ),
                            ],
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
                  bottom: 40,
                  child: SizedBox(
                    height: (MediaQuery.of(context).size.height * 1) - (MediaQuery.of(context).size.width * 1),
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
            height: MediaQuery.of(context).size.height - kToolbarHeight * 2 - kBottomNavigationBarHeight,
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
          height: MediaQuery.of(context).size.height - kToolbarHeight * 2 - kBottomNavigationBarHeight,
          child: const Center(
            child: Text("Error Occured"),
          ),
        );
      },
    );
  }
}
