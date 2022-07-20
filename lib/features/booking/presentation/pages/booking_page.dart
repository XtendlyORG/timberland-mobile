// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';

class BookingPage extends StatelessWidget {
  final bool? disableBackButton;
  const BookingPage({
    Key? key,
    this.disableBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimberlandScaffold(
      disableBackButton: disableBackButton ?? false,
      titleText: "Booking Form",
      body: Column(
        children: const [],
      ),
    );
  }
}
