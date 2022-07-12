import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/fetch_trails.dart';
import '../bloc/trail_bloc.dart';
import 'trail_widget.dart';

class TrailList extends StatelessWidget {
  const TrailList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrailBloc, TrailState>(
      builder: (context, state) {
        if (state is TrailInitial) {
          BlocProvider.of<TrailBloc>(context)
              .add(FetchTrailsEvent(fetchTrailsParams: FetchTrailsParams()));
        }
        if (state is TrailsLoaded) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
        return const RepaintBoundary(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
