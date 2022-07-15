import 'dart:developer';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/refreshable_scrollview.dart';
import '../bloc/app_info_bloc.dart';
import '../widgets/trail_rule_widget.dart';

class TrailRulesPage extends StatelessWidget {
  const TrailRulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? latestWidget;
    return RefreshableScrollView(
      onRefresh: () async {
        log('refresh trail rules');
        BlocProvider.of<AppInfoBloc>(context).add(
          const FetchTrailRulesEvent(),
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight, bottom: 10),
              child: AutoSizeText(
                'Trail Rules',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            BlocBuilder<AppInfoBloc, AppInfoState>(
              builder: (context, state) {
                if (state is LoadingTrailRules) {
                  return latestWidget = SizedBox(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight * 2 -
                        kBottomNavigationBarHeight,
                    child: const RepaintBoundary(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
                if (state is TrailRulesLoaded) {
                  return latestWidget = Padding(
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
                if (state is TrailRulesError) {
                  return latestWidget = SizedBox(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight * 2 -
                        kBottomNavigationBarHeight,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(state.message),
                        ],
                      ),
                    ),
                  );
                }
                return latestWidget ?? const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
