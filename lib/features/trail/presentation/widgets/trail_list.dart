import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../booking/presentation/bloc/booking_bloc.dart';
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
          if (BlocProvider.of<BookingBloc>(context).state is BookingInitial) {
            // populate list of trails in booking form
            BlocProvider.of<BookingBloc>(context)
                .add(PopulateTrailsEvent(trails: state.trails));
          }
          if (state.trails.isEmpty) {
            return Center(
              child: Text(
                "No Trails to show.",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                // color: Colors.black,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(.05),
                    Colors.white.withOpacity(.04),
                    Colors.white.withOpacity(.8)
                  ],
                  stops: const [.6, .8, 1],
                ),
              ),
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
