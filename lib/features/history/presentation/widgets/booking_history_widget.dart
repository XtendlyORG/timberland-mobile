// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            DateFormat.yMMMMd('en_US').format(
              bookingHistory.booking.bookDate,
            ),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text.rich(
            style: Theme.of(context).textTheme.labelLarge,
            TextSpan(
              children: [
                TextSpan(
                  text: DateFormat('hh:mm a').format(
                    DateTime(
                      0,
                      0,
                      0,
                      bookingHistory.booking.startTime.hour,
                      bookingHistory.booking.startTime.minute,
                    ),
                  ),
                ),
                const TextSpan(text: ' - '),
                TextSpan(
                  text: DateFormat('hh:mm a').format(
                    DateTime(
                      0,
                      0,
                      0,
                      bookingHistory.booking.endTime.hour,
                      bookingHistory.booking.endTime.minute,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Container(
    //       width: 120,
    //       height: 120,
    //       clipBehavior: Clip.hardEdge,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: CachedNetworkImage(
    //         imageUrl: bookingHistory.trail.featureImageUrl,
    //         fit: BoxFit.fitHeight,
    //       ),
    //     ),
    //     const SizedBox(
    //       width: kVerticalPadding,
    //     ),
    //     Expanded(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           AutoSizeText.rich(
    //             TextSpan(
    //               children: [
    //                 TextSpan(
    //                   text: '${bookingHistory.trail.difficulty.name}\n',
    //                   style: Theme.of(context).textTheme.bodyText2!.copyWith(
    //                         color: bookingHistory.trail.difficulty.primaryColor,
    //                       ),
    //                 ),
    //                 TextSpan(
    //                   text: bookingHistory.trail.trailName,
    //                   style: Theme.of(context).textTheme.titleMedium,
    //                 ),
    //               ],
    //             ),
    //             maxLines: 3,
    //           ),
    //           Text(
    //             '${bookingHistory.trail.distance} mi',
    //           ),
    //           AutoSizeText.rich(
    //             TextSpan(
    //               children: [
    //                 TextSpan(
    //                   text: DateFormat.yMd('en_US')
    //                       .format(bookingHistory.booking.bookDate),
    //                   style: Theme.of(context).textTheme.bodyText1?.copyWith(
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                 ),
    //                 TextSpan(
    //                   text: ' at ',
    //                   style: Theme.of(context).textTheme.bodyText1,
    //                 ),
    //                 TextSpan(
    //                   text: "12:00 - 03:00",
    //                   style: Theme.of(context).textTheme.bodyText1?.copyWith(
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                 ),
    //                 TextSpan(
    //                   text: ' pm for 3 hours',
    //                   style: Theme.of(context).textTheme.bodyText1,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
