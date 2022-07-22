import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';
import 'package:timberland_biketrail/features/trail/presentation/bloc/trail_bloc.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_search/trail_difficulty_checklist.dart';

import '../../../../core/presentation/widgets/refreshable_scrollview.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../widgets/trail_list.dart';
import '../widgets/trail_search/trail_search_bar.dart';

class TrailDirectory extends StatelessWidget {
  const TrailDirectory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    final user =
        (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;

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
    return Scaffold(
      key: key,
      endDrawer: Drawer(
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
          ),
        ),
        child: TrailDifficultyChecklist(
          difficulties: configs,
          searchController: searchCtrl,
        ),
      ),
      body: RefreshableScrollView(
        onRefresh: () async {
          BlocProvider.of<TrailBloc>(context)
              .add(FetchTrailsEvent(fetchTrailsParams: FetchTrailsParams()));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight),
              child: AutoSizeText(
                'Trail List',
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
                "It's Time To Ride, ${user.firstName}",
                style: Theme.of(context).textTheme.titleLarge,
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
                onOpenEndDrawer: () {
                  key.currentState!.openEndDrawer();
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
      ),
    );
  }
}
