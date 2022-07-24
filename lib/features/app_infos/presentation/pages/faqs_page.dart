import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          body: SizedBox(
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
                        child: CircularProgressIndicator(),
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
                    child: Column(
                      children: state.faqs
                          .map<Widget>(
                            (faq) => Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: FAQWidget(faq: faq),
                            ),
                          )
                          .toList(),
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
        ),
      ),
    );
  }
}
