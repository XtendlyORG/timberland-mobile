// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimberlandScaffold(
      disableBackButton: !Navigator.canPop(context),
      titleText: "Booking Form",
      body: Column(
        children: const [],
      ),
    );
  }
}
