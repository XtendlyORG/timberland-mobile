import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/features/booking/presentation/cubit/free_pass_counter_cubit.dart';

import '../../../../core/constants/padding.dart';
import '../../../../core/presentation/widgets/state_indicators/state_indicators.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/themes/timberland_color.dart';
import '../../../../core/utils/format_time.dart';
import '../../domain/entities/entities.dart';
import '../bloc/history_bloc.dart';
import '../widgets/cancel_booking/cancel_booking_bottomsheet.dart';
import '../widgets/inherited_booking.dart';

class BookingHistoryDetails extends StatelessWidget {
  const BookingHistoryDetails({
    Key? key,
    required this.bookingHistory,
  }) : super(key: key);
  final BookingHistory bookingHistory;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is CancellingBooking) {
          showLoading("Cancelling Booking...");
        }
        if (state is BookingCancellationError) {
          showError('Booking Cancellation Failed.');
          Navigator.pop(context);
        }
        if (state is BookingCancelled) {
          showSuccess('Booking Cancelled');
          BlocProvider.of<FreePassCounterCubit>(context).increment();
          Navigator.pop(context);
        }
      },
      child: DecoratedSafeArea(
        child: InheritedBooking(
          booking: bookingHistory,
          child: TimberlandScaffold(
            titleText: 'Booking Details',
            extendBodyBehindAppbar: true,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 37,
                  vertical: 40,
                ),
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                    minHeight: 380,
                  ),
                  height: MediaQuery.of(context).size.height -
                      (kToolbarHeight * 2) -
                      kHorizontalPadding * 4,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: TimberlandColor.linearGradient,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: kVerticalPadding,
                    vertical: kVerticalPadding * 2,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${bookingHistory.firstName} ',
                            ),
                            TextSpan(
                              text: bookingHistory.lastName,
                            ),
                          ],
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.phone_outlined,
                              color: TimberlandColor.lightBlue,
                            ),
                            const SizedBox(
                              width: kVerticalPadding,
                            ),
                            AutoSizeText(
                              '63${bookingHistory.mobileNumber}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            color: TimberlandColor.lightBlue,
                          ),
                          const SizedBox(
                            width: kVerticalPadding,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              bookingHistory.email,
                              style: Theme.of(context).textTheme.titleSmall,
                              maxLines: 1,
                              minFontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: kHorizontalPadding,
                      ),
                      AutoSizeText(
                        'Date and Time',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: AutoSizeText.rich(
                          TextSpan(
                            children: [
                              ..._renderTime(bookingHistory.time),
                              const TextSpan(text: ' '),
                              ..._renderDate(bookingHistory.date),
                            ],
                          ),
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        height: kHorizontalPadding,
                      ),
                      AutoSizeText.rich(
                        TextSpan(children: [
                          const TextSpan(text: 'Status: '),
                          TextSpan(
                            text: bookingHistory.status.status,
                            style: TextStyle(
                              color: bookingHistory.status.color,
                            ),
                          )
                        ]),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      FilledTextButton(
                        onPressed: (bookingHistory.date
                                        .difference(DateTime.now())
                                        .inHours <=
                                    48) ||
                                ![BookingStatus.paid, BookingStatus.free]
                                    .contains(bookingHistory.status)
                            ? null
                            : () {
                                cancelButtonHandler(context);
                              },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kVerticalPadding),
                          child: Text('Cancel Booking'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _renderTime(TimeOfDay time) {
    final splittedTime = formatTime(time).split(' ');

    return [
      TextSpan(
        text: '${splittedTime[0]} ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      TextSpan(
        text: splittedTime[1],
      ),
    ];
  }

  List<TextSpan> _renderDate(DateTime date) {
    final splittedDate = DateFormat('EEE dd MMMM yyyy').format(date).split(' ');

    final textSpanList = <TextSpan>[];
    for (int i = 0; i < splittedDate.length; i++) {
      textSpanList.add(
        TextSpan(
          text: '${splittedDate[i]} ',
          style: i != 0
              ? const TextStyle(
                  fontWeight: FontWeight.bold,
                )
              : null,
        ),
      );
    }
    return textSpanList;
  }

  void cancelButtonHandler(context) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return InheritedBooking(
          booking: bookingHistory,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * .8,
            ),
            child: const CancelBookingBottomSheet(),
          ),
        );
      },
    );
  }
}
