import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/themes/timberland_color.dart';
import '../../domain/params/fetch_trails.dart';
import '../bloc/trail_bloc.dart';
import 'trail_widget.dart';

class TrailList extends StatelessWidget {
  const TrailList({
    Key? key,
  }) : super(key: key);

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
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is TrailsLoaded) {
          if (state.trails.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.search,
                      color: TimberlandColor.primary,
                      size: 128,
                    ),
                    (state is SearchResultsLoaded)
                        ? AutoSizeText(
                            "Sorry, but there's no trail that matches your search description. Please try a different trail.",
                            style: Theme.of(context).textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "No Trails to show.",
                            style: Theme.of(context).textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                    const SizedBox(
                      height: kToolbarHeight,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(.05),
                    Colors.white.withOpacity(.04),
                    Colors.white.withOpacity(.8)
                  ],
                  stops: const [.6, .8, 1],
                ),
              ),
              margin: const EdgeInsets.only(bottom: kVerticalPadding),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.trails.length,
                padding: const EdgeInsets.all(15),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TrailWidget(
                      trail: state.trails[index],
                    ),
                  );
                },
              ),
            );
          }
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
