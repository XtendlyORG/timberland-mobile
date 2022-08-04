// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/search/submit_search.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_search/trail_difficulty_checklist.dart';

import '../../../../../core/themes/timberland_color.dart';

class TrailSearchBar extends StatefulWidget {
  final TextEditingController searchCtrl;
  final List<DifficultyChecklistConfig> configs;
  final VoidCallback showDifficultyFilter;
  const TrailSearchBar({
    Key? key,
    required this.searchCtrl,
    required this.configs,
    required this.showDifficultyFilter,
  }) : super(key: key);

  @override
  State<TrailSearchBar> createState() => _TrailSearchBarState();
}

class _TrailSearchBarState extends State<TrailSearchBar>
    with WidgetsBindingObserver {
  late bool showIconLabels;
  late FocusNode searchFocusNode;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    searchFocusNode = FocusNode();
    showIconLabels = true;
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    if (!WidgetsBinding.instance.isRootWidgetAttached) {
      searchFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              focusNode: searchFocusNode,
              controller: widget.searchCtrl,
              textInputAction: TextInputAction.go,
              onTap: () {
                setState(() {
                  showIconLabels = false;
                });
              },
              onChanged: (_) {
                setState(() {
                  showIconLabels = false;
                });
              },
              onEditingComplete: () {
                setState(() {
                  showIconLabels = true;
                });
              },
              onFieldSubmitted: (val) {
                submitSearch(
                  context: context,
                  name: widget.searchCtrl.text,
                  difficultyConfigs: widget.configs,
                );
                if (searchFocusNode.hasFocus) {
                  searchFocusNode.unfocus();
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                fillColor: TimberlandColor.primary.withOpacity(.05),
                contentPadding:
                    const EdgeInsets.only(top: 12), //align icons to hint text
                hintText: 'Trail Name',
                prefixIcon: const Icon(
                  Icons.search,
                ),
                prefixIconColor: Theme.of(context).disabledColor,
                suffixIcon: GestureDetector(
                  onTap: () {
                    widget.searchCtrl.clear();
                    searchFocusNode.unfocus();
                    setState(() {
                      showIconLabels = true;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Theme.of(context).disabledColor,
                      ),
                      const Icon(
                        Icons.close,
                        size: 16,
                        color: TimberlandColor.subtext,
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
              setState(() {
                showIconLabels = true;
              });
              widget.showDifficultyFilter();
            },
            child: Row(
              children: [
                if (showIconLabels) const Text('Filter'),
                Icon(
                  Icons.filter_alt_outlined,
                  color: Theme.of(context).disabledColor,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                showIconLabels = true;
              });
              context.pushNamed(Routes.trailMap.name);
            },
            child: Row(
              children: [
                if (showIconLabels) const Text('Trail Map'),
                Icon(
                  Icons.map_outlined,
                  color: Theme.of(context).disabledColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
