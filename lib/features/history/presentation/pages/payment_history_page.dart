import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/themes/timberland_color.dart';
import '../bloc/history_bloc.dart';
import '../widgets/payment_history_widget.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? latestWidget;
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HistoryBloc>(context).add(
          const FetchPaymentHistory(),
        );
      },
      child: TimberlandScaffold(
        titleText: 'Payment History',
        extendBodyBehindAppbar: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding, vertical: kHorizontalPadding),
          child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is LoadingHistory) {
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
              if (state is PaymentHistoryLoaded) {
                if (state.payments.isEmpty) {
                  return latestWidget = SizedBox(
                    height:
                        MediaQuery.of(context).size.height - kToolbarHeight * 5,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.history_rounded,
                              color: TimberlandColor.primary,
                              size: 128,
                            ),
                            Text(
                              "No payment history to show",
                              style: Theme.of(context).textTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: kToolbarHeight,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return LiveList.options(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  options: const LiveOptions(
                    showItemInterval: Duration(milliseconds: 100),
                    visibleFraction: 0.05,
                  ),
                  shrinkWrap: true,
                  itemCount: state.payments.length,
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
                          padding:
                              const EdgeInsets.only(bottom: kVerticalPadding),
                          child: PaymentHistoryWidget(
                              payment: state.payments[index]),
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is HistoryError) {
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
                        Text(state.errorMessage),
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
    );
  }
}
