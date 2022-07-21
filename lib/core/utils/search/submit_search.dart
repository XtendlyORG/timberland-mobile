import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';
import 'package:timberland_biketrail/features/trail/domain/params/search_trails.dart';
import 'package:timberland_biketrail/features/trail/presentation/bloc/trail_bloc.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_search/trail_difficulty_checklist.dart';

void submitSearch({
  required BuildContext context,
  required String name,
  required List<DifficultyChecklistConfig> difficultyConfigs,
}) {
  final List<DifficultyLevel> difficuties = [
    ...difficultyConfigs
        .where((config) => config.value)
        .map((e) => e.difficultyLevel)
  ];

  BlocProvider.of<TrailBloc>(context).add(
    SearchTrailsEvent(
      searchParams: SearchTrailsParams(
        name: name,
        difficulties: difficuties,
      ),
    ),
  );
}
