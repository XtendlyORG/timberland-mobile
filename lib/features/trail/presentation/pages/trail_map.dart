// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_appbar.dart';

import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';

class TrailMap extends StatelessWidget {
  const TrailMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    decoration: InputDecoration(
                      hintText: "Trail Name",
                      hintStyle: Theme.of(context).textTheme.labelLarge,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      prefixIcon: const BackButton(),
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
                PopupMenuButton(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Difficulty",
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                  onSelected: (val) {},
                  itemBuilder: (context) {
                    final List<DifficultyLevel> difficulties = [
                      Difficulties.easy,
                      Difficulties.moderate,
                      Difficulties.hard,
                    ];
                    return difficulties
                        .map(
                          (element) => PopupMenuItem(
                            child: Text(element.name),
                          ),
                        )
                        .toList();
                  },
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
