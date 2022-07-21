// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/router/router.dart';

import 'package:timberland_biketrail/core/utils/search/show_trail_filter_bottomsheet.dart';
import 'package:timberland_biketrail/core/utils/search/submit_search.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';

import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_search/trail_difficulty_checklist.dart';

import '../../../../../core/themes/timberland_color.dart';

class TrailSearchBar extends StatelessWidget {
  const TrailSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchCtrl = TextEditingController();

    final List<DifficultyChecklistConfig> configs = [
      DifficultyChecklistConfig(
        difficultyLevel: Difficulties.easy,
        value: false,
      ),
      DifficultyChecklistConfig(
        difficultyLevel: Difficulties.moderate,
        value: false,
      ),
      DifficultyChecklistConfig(
        difficultyLevel: Difficulties.hard,
        value: false,
      ),
    ];

    return Row(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: searchCtrl,
              textInputAction: TextInputAction.go,
              onFieldSubmitted: (val) {
                //TODO: FETCH FILTERED TRAILS HERE
                submitSearch(
                  context: context,
                  name: searchCtrl.text,
                  difficultyConfigs: configs,
                );
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                fillColor: TimberlandColor.primary.withOpacity(.05),
                hintText: 'Trail Name',
                prefixIcon: const Icon(
                  Icons.search,
                ),
                prefixIconColor: Theme.of(context).disabledColor,
                suffixIcon: GestureDetector(
                  onTap: () {
                    searchCtrl.clear();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      Icon(Icons.circle),
                      Icon(
                        Icons.close,
                        size: 16,
                        color: TimberlandColor.text,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () {
              showTrailFilterBottomSheet(
                context: context,
                difficultiesConfigs: configs,
                searchController: searchCtrl,
              );
            },
            child: Icon(
              Icons.filter_alt_outlined,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () {
              context.pushNamed(Routes.trailMap.name);
            },
            child: Icon(
              Icons.map_outlined,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ),
      ],
    );
  }
}
