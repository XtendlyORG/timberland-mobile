// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/utils/format_time.dart';
import 'package:timberland_biketrail/features/history/domain/entities/entities.dart';

class BookingHistoryWidget extends StatelessWidget {
  final BookingHistory bookingHistory;
  const BookingHistoryWidget({
    Key? key,
    required this.bookingHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(kVerticalPadding),
      constraints: const BoxConstraints(minHeight: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: AutoSizeText.rich(
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
              maxLines: 1,
              TextSpan(
                children: [
                  TextSpan(
                    text: DateFormat.yMMMMd('en_US').format(
                      bookingHistory.date,
                    ),
                  ),
                  const TextSpan(text: '\t\t'),
                  TextSpan(
                    text: formatTime(bookingHistory.time),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const TextSpan(text: ' - '),
                  TextSpan(
                    text: DateFormat('hh:mm a').format(
                      DateTime(
                        0,
                        0,
                        0,
                        17,
                        0,
                      ),
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
