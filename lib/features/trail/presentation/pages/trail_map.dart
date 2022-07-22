// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/utils/search/submit_search.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_search/trail_difficulty_checklist.dart';

class TrailMap extends StatelessWidget {
  const TrailMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchCtrl = TextEditingController();
    final TextEditingController difficultyCtrl = TextEditingController();

    return TimberlandScaffold(
      physics: const NeverScrollableScrollPhysics(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: searchCtrl,
                    textInputAction: TextInputAction.go,
                    onFieldSubmitted: (val) {
                      submitSearch(
                        context: context,
                        name: searchCtrl.text,
                        difficultyConfigs: [
                          if (difficultyCtrl.text.isNotEmpty)
                            DifficultyChecklistConfig(
                              difficultyLevel: DifficultyLevel.fromString(
                                difficultyCtrl.text,
                              ),
                              value: true,
                            ),
                        ],
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "Trail Name",
                      hintStyle: Theme.of(context).textTheme.labelLarge,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      prefixIcon: const BackButton(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          submitSearch(
                            context: context,
                            name: searchCtrl.text,
                            difficultyConfigs: [
                              if (difficultyCtrl.text.isNotEmpty)
                                DifficultyChecklistConfig(
                                  difficultyLevel: DifficultyLevel.fromString(
                                    difficultyCtrl.text,
                                  ),
                                  value: true,
                                ),
                            ],
                          );
                        },
                        icon: const Icon(Icons.search_rounded),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Theme.of(context).primaryColor.withOpacity(.2),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                DifficultyPopUpMenu(
                  difficultyController: difficultyCtrl,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.longestSide -
            kToolbarHeight -
            kBottomNavigationBarHeight -
            MediaQuery.of(context).padding.top,
        child: PhotoView(
          basePosition: const Alignment(.5, 0),
          initialScale: PhotoViewComputedScale.covered,
          maxScale: 1.0,
          minScale: .5,
          imageProvider: const AssetImage(
            'assets/images/trail-map.png',
          ),
        ),
      ),
    );
  }
}

class DifficultyPopUpMenu extends StatefulWidget {
  final TextEditingController difficultyController;
  const DifficultyPopUpMenu({
    Key? key,
    required this.difficultyController,
  }) : super(key: key);

  @override
  State<DifficultyPopUpMenu> createState() => _DifficultyPopUpMenuState();
}

class _DifficultyPopUpMenuState extends State<DifficultyPopUpMenu> {
  late DifficultyLevel? selectedDifficulty;

  @override
  void initState() {
    super.initState();
    selectedDifficulty = null;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (val) {
        setState(() {
          selectedDifficulty = val as DifficultyLevel;
          widget.difficultyController.text = selectedDifficulty!.name;
        });
      },
      tooltip: "Difficulties",
      itemBuilder: (context) {
        return Difficulties.all
            .map(
              (element) => PopupMenuItem(
                value: element,
                child: Text(element.name),
              ),
            )
            .toList();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Text(
              selectedDifficulty?.name ?? "Difficulties",
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Theme.of(context).backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
