import 'package:flutter/material.dart';

import '../../../features/trail/presentation/widgets/trail_search/trail_difficulty_checklist.dart';

final routeTypes = [
  RouteTypeChecklistConfig(
    routeType: 'Climbing',
    value: false,
  ),
  RouteTypeChecklistConfig(
    routeType: 'Descending',
    value: false,
  ),
  RouteTypeChecklistConfig(
    routeType: 'Rolling',
    value: false,
  ),
];

showTrailFilterBottomSheet({
  required BuildContext context,
  required List<DifficultyChecklistConfig> difficultiesConfigs,
  required TextEditingController searchController,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).primaryColor,
    isScrollControlled: true,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * .8,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TrailFilterCheckList(
                difficulties: difficultiesConfigs,
                searchController: searchController,
                routeTypes: routeTypes,
              ),
            ],
          ),
        ),
      );
    },
  );
}
