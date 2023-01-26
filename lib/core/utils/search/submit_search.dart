import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/trail/domain/entities/difficulty.dart';
import '../../../features/trail/domain/params/search_trails.dart';
import '../../../features/trail/presentation/bloc/trail_bloc.dart';
import '../../../features/trail/presentation/widgets/trail_search/trail_difficulty_checklist.dart';

void submitSearch({
  required BuildContext context,
  required String name,
  required List<DifficultyChecklistConfig> difficultyConfigs,
  required List<RouteTypeChecklistConfig> routeTypeConfigs,
}) {
  final List<DifficultyLevel> difficuties = [
    ...difficultyConfigs
        .where((config) => config.value)
        .map((e) => e.difficultyLevel)
  ];

  final List<String> routeTypes = [
    ...routeTypeConfigs.where((config) => config.value).map((e) => e.routeType)
  ];

  BlocProvider.of<TrailBloc>(context).add(
    SearchTrailsEvent(
      searchParams: SearchTrailsParams(
        name: name,
        difficulties: difficuties,
        routeTypes: routeTypes,
      ),
    ),
  );
}
