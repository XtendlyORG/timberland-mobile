// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_checkbox.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_styled_text.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
import 'package:timberland_biketrail/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/waiver/waiver_content.dart';

class BookingWaiver extends StatefulWidget {
  final BookingRequestParams bookingRequestParams;
  const BookingWaiver({
    Key? key,
    required this.bookingRequestParams,
  }) : super(key: key);

  @override
  State<BookingWaiver> createState() => _BookingWaiverState();
}

class _BookingWaiverState extends State<BookingWaiver> {
  bool waiverAccepted = false;
  @override
  Widget build(BuildContext context) {
    return DecoratedSafeArea(
      child: TimberlandScaffold(
        titleText: 'Waiver',
        extendBodyBehindAppbar: true,
        index: 2,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kVerticalPadding,
            vertical: kHorizontalPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: TimberlandColor.linearGradient,
                ),
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: CustomStyledText(
                        text: waiverContent(
                          '${widget.bookingRequestParams.firstName} ${widget.bookingRequestParams.lastName}',
                        ),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kVerticalPadding,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCheckbox(
                      onChange: (val) {
                        waiverAccepted = val;
                      },
                      child: Text(
                        'I agree to the terms and conditions',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledTextButton(
                  onPressed: () {
                    if (waiverAccepted) {
                      BlocProvider.of<BookingBloc>(context).add(
                        SubmitBookingRequest(
                            params: widget.bookingRequestParams),
                      );
                      return;
                    }
                    showToast('Waiver not accepted.');
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
