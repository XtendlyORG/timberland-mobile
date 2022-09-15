import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/features/history/presentation/widgets/inherited_booking.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/themes/timberland_color.dart';
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
                  height:
                      MediaQuery.of(context).size.height - kToolbarHeight * 5,
                  child: const RepaintBoundary(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                );
              }
              if (state is BookingHistoryLoaded) {
                if (state.bookings.isEmpty) {
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
                              "No booking history to show",
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
                return Column(
                  children: [
                    ...state.bookings
                        .map(
                          (booking) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: kVerticalPadding),
                            child: InheritedBooking(
                              booking: booking,
                              child: const BookingHistoryWidget(),
                            ),
                          ),
                        )
                        .toList()
                  ],
                );
              }
              if (state is HistoryError) {
                return latestWidget = SizedBox(
                  height:
                      MediaQuery.of(context).size.height - kToolbarHeight * 5,
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
