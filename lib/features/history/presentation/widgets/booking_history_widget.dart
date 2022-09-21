// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/format_time.dart';
import 'package:timberland_biketrail/features/history/domain/entities/entities.dart';
import 'package:timberland_biketrail/features/history/presentation/widgets/inherited_booking.dart';

class BookingHistoryWidget extends StatelessWidget {
  const BookingHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingHistory bookingHistory = InheritedBooking.of(context).booking;
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.bookingHistoryDetails.name,
          extra: bookingHistory,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(kVerticalPadding),
        constraints: const BoxConstraints(minHeight: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              DateFormat.yMMMMd('en_US').format(
                bookingHistory.date,
              ),
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  DateFormat('hh:mm a').format(
                    DateTime(0, 0, 0, 17, 0),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
                AutoSizeText(
                  bookingHistory.status.status,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: bookingHistory.status.color,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
