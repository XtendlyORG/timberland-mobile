// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/utils/search/submit_search.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';
import 'package:timberland_biketrail/features/trail/domain/params/search_trails.dart';
import 'package:timberland_biketrail/features/trail/presentation/bloc/trail_bloc.dart';

class TrailDifficultyChecklist extends StatefulWidget {
  final List<DifficultyChecklistConfig> difficulties;
  final TextEditingController searchController;
  final bool popSearchDelegate;
  const TrailDifficultyChecklist({
    Key? key,
    required this.difficulties,
    required this.searchController,
    this.popSearchDelegate = false,
  }) : super(key: key);

  @override
  State<TrailDifficultyChecklist> createState() =>
      _TrailDifficultyChecklistState();
}

class _TrailDifficultyChecklistState extends State<TrailDifficultyChecklist> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
        child: SingleChildScrollView(
          child: Column(
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
              Padding(
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
                          );
                          Navigator.pop(context);
                          widget.popSearchDelegate
                              ? Navigator.pop(context)
                              : null;
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).backgroundColor,
                          textStyle:
                              Theme.of(context).textTheme.button?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                        child: const Text("See 20 Trails"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
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
