import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
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
      child: DecoratedSafeArea(
        child: TimberlandScaffold(
          titleText: 'Booking History',
          index: 3,
          extendBodyBehindAppbar: true,
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
                  return LiveList.options(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    options: const LiveOptions(
                      showItemInterval: Duration(milliseconds: 100),
                      visibleFraction: 0.05,
                    ),
                    shrinkWrap: true,
                    itemCount: state.bookings.length,
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
                            child: InheritedBooking(
                              booking: state.bookings[index],
                              child: const BookingHistoryWidget(),
                            ),
                          ),
                        ),
                      );
                    },
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
      ),
    );
  }
}
