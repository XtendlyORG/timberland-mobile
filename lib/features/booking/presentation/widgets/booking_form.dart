// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/presentation/widgets/form_fields/email_field.dart';
import 'package:timberland_biketrail/core/presentation/widgets/form_fields/mobile_number_field.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/booking/presentation/widgets/booking_date_picker.dart';
import 'package:timberland_biketrail/features/booking/presentation/widgets/booking_time_picker.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../trail/domain/entities/trail.dart';
import '../bloc/booking_bloc.dart';
import 'trail_list_dropdown.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;
  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  late final GlobalKey<FormState> formKey;
  late DateTime? chosenDate;
  late TextEditingController dateCtrl;
  late TextEditingController timeRangeCtrl;
  late TextEditingController mobileNumberCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController fullNameCtrl;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    chosenDate = null;
    dateCtrl = TextEditingController();
    timeRangeCtrl = TextEditingController();
    mobileNumberCtrl = TextEditingController(text: widget.user.mobileNumber);
    emailCtrl = TextEditingController(
      text: widget.user.email,
    );
    fullNameCtrl = TextEditingController(
      text: '${widget.user.firstName} ${widget.user.lastName}',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      buildWhen: (previous, current) {
        if (current is BookingInitial) {
          BlocProvider.of<BookingBloc>(context).add(
            const FetchAvailabilityEvent(),
          );
        }
        return current is BookingAvailabilityLoaded;
      },
      builder: (context, state) {
        if (state is! BookingAvailabilityLoaded) {
          BlocProvider.of<BookingBloc>(context)
              .add(const FetchAvailabilityEvent());
        }
        if (state is BookingAvailabilityLoaded) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: kVerticalPadding,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Date'),
                            ExcludeFocus(
                              child: BookingDatePicker(
                                controller: dateCtrl,
                                enabled: true,
                                onSubmit: (value) {
                                  if (value is DateTime) {
                                    chosenDate = value;
                                    log(chosenDate.toString());
                                    dateCtrl.text =
                                        DateFormat.yMd('en_US').format(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: kVerticalPadding,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Take Off Time'),
                            ExcludeFocus(
                              child: BookingTimePicker(
                                controller: timeRangeCtrl,
                                enabled: true,
                                onSubmit: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: kVerticalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Full Name"),
                      TextFormField(
                        controller: fullNameCtrl,
                        decoration: const InputDecoration(
                          hintText: "Full Name",
                        ),
                        validator: (fullName) {
                          if (fullName == null || fullName.isEmpty) {
                            return 'Field can not be emtpy.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: kVerticalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Mobile Number'),
                      MobileNumberField(
                        controller: mobileNumberCtrl,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: kVerticalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Email Address"),
                      EmailField(
                        controller: emailCtrl,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledTextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        log('Booked');
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: RepaintBoundary(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
