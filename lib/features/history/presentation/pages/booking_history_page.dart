import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../bloc/history_bloc.dart';
import '../widgets/booking_history_widget.dart';

class BookingHistoryPage extends StatelessWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? latestWidget;
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HistoryBloc>(context).add(
          const FetchBookingHistory(),
        );
      },
      child: TimberlandScaffold(
        titleText: 'Booking History',
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
              if (state is BookingHistoryLoaded) {
                return Column(
                  children: [
                    ...state.bookings
                        .map(
                          (booking) => Padding(
                            padding: const EdgeInsets.only(bottom: kVerticalPadding),
                            child: BookingHistoryWidget(
                              bookingHistory: booking,
                            ),
                          ),
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
