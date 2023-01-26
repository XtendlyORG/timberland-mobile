// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/core/utils/search/submit_search.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';

class TrailFilterCheckList extends StatefulWidget {
  final List<DifficultyChecklistConfig> difficulties;
  final List<RouteTypeChecklistConfig> routeTypes;
  final TextEditingController searchController;

  const TrailFilterCheckList({
    Key? key,
    required this.difficulties,
    required this.routeTypes,
    required this.searchController,
  }) : super(key: key);

  @override
  State<TrailFilterCheckList> createState() => _TrailFilterCheckListState();
}

class _TrailFilterCheckListState extends State<TrailFilterCheckList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            const SizedBox(
              height: kVerticalPadding,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Difficulty",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).backgroundColor,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: kVerticalPadding,
            ),
            ...widget.difficulties
                .map(
                  (difficulty) => CheckboxListTile(
                    value: difficulty.value,
                    title: Text(difficulty.difficultyLevel.name),
                    activeColor: Colors.white,
                    checkColor: Theme.of(context).primaryColor,
                    side: BorderSide(
                      style: BorderStyle.solid,
                      color: Theme.of(context).backgroundColor,
                    ),
                    onChanged: (value) {
                      setState(() {
                        difficulty.value = value ?? difficulty.value;
                      });
                    },
                  ),
                )
                .toList(),
            const SizedBox(
              height: kVerticalPadding,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kVerticalPadding),
              child: Divider(
                color: TimberlandColor.background,
                thickness: 2,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Route Types",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).backgroundColor,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: kVerticalPadding,
            ),
            ...widget.routeTypes
                .map(
                  (routeTypeConf) => CheckboxListTile(
                    value: routeTypeConf.value,
                    title: Text(routeTypeConf.routeType),
                    activeColor: Colors.white,
                    checkColor: Theme.of(context).primaryColor,
                    side: BorderSide(
                      style: BorderStyle.solid,
                      color: Theme.of(context).backgroundColor,
                    ),
                    onChanged: (value) {
                      setState(() {
                        routeTypeConf.value = value ?? routeTypeConf.value;
                      });
                    },
                  ),
                )
                .toList(),
            const SizedBox(
              height: kVerticalPadding,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Theme.of(context).backgroundColor),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextButton(
                        onPressed: () {
                          submitSearch(
                            context: context,
                            name: widget.searchController.text,
                            difficultyConfigs: widget.difficulties,
                            routeTypeConfigs: widget.routeTypes,
                          );
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).backgroundColor,
                          textStyle:
                              Theme.of(context).textTheme.button?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                        child: const Text("See Trails"),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DifficultyChecklistConfig {
  final DifficultyLevel difficultyLevel;
  bool value;
  DifficultyChecklistConfig({
    required this.difficultyLevel,
    required this.value,
  });
}

class RouteTypeChecklistConfig {
  final String routeType;
  bool value;
  RouteTypeChecklistConfig({
    required this.routeType,
    required this.value,
  });
}
