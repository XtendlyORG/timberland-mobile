import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
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
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
              if (state is PaymentHistoryLoaded) {
                return Column(
                  children: [
                    ...state.payments
                        .map(
                          (payment) => PaymentHistoryWidget(payment: payment),
                        )
                        .toList()
                  ],
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
