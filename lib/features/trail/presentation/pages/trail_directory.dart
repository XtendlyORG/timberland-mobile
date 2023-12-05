import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/refreshable_scrollview.dart';
import '../../../../core/utils/search/show_trail_filter_bottomsheet.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/difficulty.dart';
import '../../domain/params/fetch_trails.dart';
import '../bloc/trail_bloc.dart';
import '../widgets/trail_list.dart';
import '../widgets/trail_search/trail_difficulty_checklist.dart';
import '../widgets/trail_search/trail_search_bar.dart';

class TrailDirectory extends StatelessWidget {
  const TrailDirectory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;

    final searchCtrl = TextEditingController();

    List<DifficultyChecklistConfig> configs = Difficulties.all
        .map(
          (diff) => DifficultyChecklistConfig(
            difficultyLevel: diff,
            value: false,
          ),
        )
        .toList();

    return RefreshableScrollView(
      onRefresh: () async {
        BlocProvider.of<TrailBloc>(context).add(FetchTrailsEvent(fetchTrailsParams: FetchTrailsParams()));
        configs = Difficulties.all
            .map(
              (diff) => DifficultyChecklistConfig(
                difficultyLevel: diff,
                value: false,
              ),
            )
            .toList();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: AutoSizeText(
              'Trail Directory',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "It's Time To Ride ${user.firstName},",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "tap on any of the tiles to explore the TMBP trail system",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TrailSearchBar(
              searchCtrl: searchCtrl,
              configs: configs,
              showDifficultyFilter: () {
                showTrailFilterBottomSheet(
                  context: context,
                  difficultiesConfigs: configs,
                  searchController: searchCtrl,
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Flexible(
            fit: FlexFit.loose,
            child: TrailList(),
          ),
        ],
      ),
    );
  }
}
