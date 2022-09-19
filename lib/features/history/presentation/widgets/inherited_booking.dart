// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:timberland_biketrail/features/history/domain/entities/entities.dart';

class InheritedBooking extends InheritedWidget {
  final BookingHistory booking;
  const InheritedBooking({
    required super.child,
    super.key,
    required this.booking,
  });

  static InheritedBooking of(BuildContext context) {
    final InheritedBooking? result =
        context.dependOnInheritedWidgetOfExactType<InheritedBooking>();
    assert(result != null, 'No booking found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedBooking oldWidget) {
    return oldWidget.booking != booking;
  }
}
