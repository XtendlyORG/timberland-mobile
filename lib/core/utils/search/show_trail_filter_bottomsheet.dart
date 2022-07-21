import 'package:flutter/material.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_search/trail_difficulty_checklist.dart';

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
        child: TrailDifficultyChecklist(
          difficulties: difficultiesConfigs,
          searchController: searchController,
        ),
      );
    },
  );
}
