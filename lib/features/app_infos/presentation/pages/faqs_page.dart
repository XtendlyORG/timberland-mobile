import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/router/router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/timberland_scaffold.dart';
import '../bloc/app_info_bloc.dart';
import '../widgets/faq_widget.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? latestWidget;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<AppInfoBloc>(context).add(
            const FetchFAQSEvent(),
          );
        },
        child: TimberlandScaffold(
          titleText: 'FAQs',
          extendBodyBehindAppbar: true,
          body: Column(
            children: [
              const SizedBox(height: kVerticalPadding),
              Text(
                'Want to know how to use the app?',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.onboarding.name);
                },
                child: Text(
                  'Get Started',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<AppInfoBloc, AppInfoState>(
                  builder: (context, state) {
                    if (state is LoadingFAQs) {
                      return latestWidget = SizedBox(
                        height: MediaQuery.of(context).size.height -
                            kToolbarHeight * 2 -
                            kBottomNavigationBarHeight,
                        child: const RepaintBoundary(
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                      );
                    }
                    if (state is FAQsLoaded) {
                      return latestWidget = Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding,
                          vertical: kVerticalPadding * 3,
                        ),
                        child: LiveList.options(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          options: const LiveOptions(
                            showItemInterval: Duration(milliseconds: 100),
                            visibleFraction: 0.05,
                          ),
                          shrinkWrap: true,
                          itemCount: state.faqs.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index, animation) {
                            return FadeTransition(
                              opacity: Tween<double>(
                                begin: 0,
                                end: 1,
                              ).animate(animation),
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(-.5, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: FAQWidget(
                                    faq: state.faqs[index],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    if (state is FAQError) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
