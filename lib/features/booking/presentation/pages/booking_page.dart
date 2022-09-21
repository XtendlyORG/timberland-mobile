// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_scroll_behavior.dart';
import 'package:timberland_biketrail/core/presentation/widgets/refreshable_scrollview.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/booking/presentation/widgets/booking_form.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const CustomScrollBehavior(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight, bottom: 10),
                child: AutoSizeText(
                  'Booking Form',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                  vertical: kVerticalPadding,
                ),
                child: AutoSizeText(
                  'Please fill the required identity and booking detail below.',
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: kVerticalPadding,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) {
                  return current is Authenticated;
                },
                builder: (context, state) {
                  return BookingForm(
                    user: (state as Authenticated).user,
                  );
                },
              ),
              const SizedBox(
                height: kToolbarHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
