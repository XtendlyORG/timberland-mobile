import 'dart:developer';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/presentation/widgets/refreshable_scrollview.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/bloc/app_info_bloc.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/trail_rule_widget.dart';

class TrailRulesPage extends StatelessWidget {
  const TrailRulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshableScrollView(
      onRefresh: () async {
        log('refresh trail rules');
        BlocProvider.of<AppInfoBloc>(context).add(
          const FetchTrailRulesEvent(),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: AutoSizeText(
              'Trail Rules',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          BlocBuilder<AppInfoBloc, AppInfoState>(
            builder: (context, state) {
              if (state is AppInfoInitial) {
                BlocProvider.of<AppInfoBloc>(context).add(
                  const FetchTrailRulesEvent(),
                );
              }
              if (state is LoadingTrailRules) {
                return const RepaintBoundary(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is TrailRulesLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(.05),
                          Colors.white.withOpacity(.04),
                          Colors.white.withOpacity(.8)
                        ],
                        stops: const [.6, .8, 1],
                      ),
                    ),
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            children: state.trailRules
                                .map<Widget>(
                                  (rule) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: TrailRuleWidget(trailRule: rule),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (state is TrailRuleError) {
                log(state.message);
              }
              return const Center(
                child: Text("Error Occured"),
              );
            },
          ),
        ],
      ),
    );
  }
}
