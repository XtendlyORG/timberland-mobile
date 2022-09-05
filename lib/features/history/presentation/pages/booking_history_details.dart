import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/padding.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/themes/timberland_color.dart';
import '../../../../core/utils/format_time.dart';
import '../../domain/entities/entities.dart';
import '../widgets/cancel_booking_bottomsheet.dart';
import '../widgets/cancel_booking_dialog.dart';

class BookingHistoryDetails extends StatelessWidget {
  const BookingHistoryDetails({
    Key? key,
    required this.bookingHistory,
  }) : super(key: key);
  final BookingHistory bookingHistory;

  @override
  Widget build(BuildContext context) {
    return TimberlandScaffold(
      titleText: 'Booking Details',
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
                  height: kToolbarHeight,
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
                      style: Theme.of(context).textTheme.titleSmall),
                ),
                const Spacer(),
                FilledTextButton(
                  onPressed: bookingHistory.date
                              .difference(DateTime.now())
                              .inHours <=
                          48
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return CancelBookingDialog();
                            },
                          ).then((value) {
                            if (value is bool && value) {
                              showModalBottomSheet(
                                context: context,
                                clipBehavior: Clip.hardEdge,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                isScrollControlled: true,
                                builder: (context) {
                                  return Container(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              .8,
                                    ),
                                    child: CancelBookingBottomSheet(),
                                  );
                                },
                              );
                            }
                          });
                        },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kVerticalPadding),
                    child: Text('Cancel Booking'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _renderTime(TimeOfDay time) {
    final _time = formatTime(time).split(' ');

    return [
      TextSpan(
        text: '${_time[0]} ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      TextSpan(
        text: _time[1],
      ),
    ];
  }

  List<TextSpan> _renderDate(DateTime date) {
    final _date = DateFormat('EEE dd MMMM yyyy').format(date).split(' ');

    final textSpanList = <TextSpan>[];
    for (int i = 0; i < _date.length; i++) {
      textSpanList.add(
        TextSpan(
          text: '${_date[i]} ',
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
}
