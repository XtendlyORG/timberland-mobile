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
        padding: const EdgeInsets.symmetric(
            horizontal: kVerticalPadding, vertical: kHorizontalPadding),
        child: Column(
          children: [
            ...List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: kVerticalPadding),
                child: BookingHistoryWidget(
                  bookingHistory: BookingHistory(
                    booking: Booking(
                      bookingId: "booking-id",
                      bookDate: DateTime.now(),
                      startTime: TimeOfDay.now(),
                      endTime: TimeOfDay(
                        hour: TimeOfDay.now().hour + 3,
                        minute: 0,
                      ),
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
