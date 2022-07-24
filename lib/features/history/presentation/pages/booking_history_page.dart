import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../booking/domain/entities/booking.dart';
import '../../../trail/domain/entities/difficulty.dart';
import '../../../trail/domain/entities/trail.dart';
import '../../domain/entities/booking_history.dart';
import '../widgets/booking_history_widget.dart';

class BookingHistoryPage extends StatelessWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimberlandScaffold(
      titleText: 'Booking History',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:kVerticalPadding,vertical: kHorizontalPadding),
        child: Column(
          children: [
            ...List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: kVerticalPadding),
                child: BookingHistoryWidget(
                  bookingHistory: BookingHistory(
                    trail: const Trail(
                      trailId: "trail-id",
                      length: 90,
                      elevationGain: 123,
                      featureImageUrl:
                          'https://gttp.imgix.net/328721/x/0/17-best-biking-spots-in-manila-and-nearby-bike-trails-scenic-routes-beginner-friendly-9.jpg?auto=compress%2Cformat&ch=Width%2CDPR&dpr=1&ixlib=php-3.3.0&w=883',
                      mapImageUrl:
                          'https://live.staticflickr.com/7300/9151350000_8c94e1511a_b.jpg',
                      routeType: "Loop",
                      trailName: 'Timberland Blue Trail to Nursery Loop',
                      difficulty: Difficulties.easy,
                      description:
                          'Qui ut eiusmod consequat minim. Magna sit do dolor tempor culpa do sint duis esse irure cupidatat Lorem. Eu ad mollit sint cupidatat labore culpa nostrud consectetur cillum incididunt. Reprehenderit exercitation fugiat sit in ea enim qui nisi ipsum irure eiusmod nulla sit.',
                      location: 'San Mateo, Quezon, Philippines',
                    ),
                    booking: Booking(
                      bookingId: "booking-id",
                      bookDate: DateTime.now(),
                      serviceId: "dervice-id",
                      userId: 'user-id',
                      status: 'completed',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
