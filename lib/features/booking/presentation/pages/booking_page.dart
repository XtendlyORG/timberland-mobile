// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/booking/presentation/cubit/free_pass_counter_cubit.dart';
import 'package:timberland_biketrail/features/booking/presentation/widgets/booking_form.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshableScrollView(
      onRefresh: () async {
        BlocProvider.of<FreePassCounterCubit>(context).getFreePassCount();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            //new
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
                'Please fill the required identity and booking details below.',
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

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalPadding,
                vertical: kVerticalPadding,
              ),
              child: AutoSizeText(
                'Park Opens: 7:30AM\nLast Entry: 2:00PM\nPark Closes: 4:00PM',
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: kToolbarHeight,
            ),
          ],
        ),
      ),
    );
  }
}
