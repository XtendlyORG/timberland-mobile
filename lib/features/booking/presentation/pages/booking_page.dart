// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/inherited_widgets/inherited_trail.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return TimberlandScaffold(
      disableBackButton: !Navigator.canPop(context),
      titleText: "Booking Form",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            const SizedBox(
              height: kVerticalPadding,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: AutoSizeText(
                'Please fill the required identity and booking detail below.',
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            
            const BookingForm(),
          ],
        ),
      ),
    );
  }
}

class BookingForm extends StatelessWidget {
  const BookingForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Trail? trail = InheritedTrail.of(context).trail;
    final GlobalKey formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(trail?.trailName??"No trail passed"),
        ],
      ),
    );
  }
}
