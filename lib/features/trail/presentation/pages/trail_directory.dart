import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/refreshable_scrollview.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../widgets/trail_list.dart';
import '../widgets/trail_search_bar.dart';

class TrailDirectory extends StatelessWidget {
  const TrailDirectory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =
        (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;
    return RefreshableScrollView(
      onRefresh: () async {},
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TrailSearchBar(),
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
