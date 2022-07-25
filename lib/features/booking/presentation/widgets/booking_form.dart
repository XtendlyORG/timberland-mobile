// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../trail/domain/entities/trail.dart';
import '../bloc/booking_bloc.dart';
import 'trail_list_dropdown.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({
    Key? key,
    required this.trail,
  }) : super(key: key);

  final Trail? trail;
  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  late Trail? selectedTrail;
  late final GlobalKey<FormState> formKey;
  late DateTime? chosenDate;
  late TextEditingController dateController;

  @override
  void initState() {
    selectedTrail = widget.trail;
    formKey = GlobalKey<FormState>();
    chosenDate = null;
    dateController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      buildWhen: (previous, current) {
        if (current is BookingInitial) {
          BlocProvider.of<BookingBloc>(context).add(
            FetchAllTrailsBookingEvent(),
          );
        }
        return current is BookingAvailabilityLoaded;
      },
      builder: (context, state) {
        if (state is BookingAvailabilityLoaded) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: kVerticalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Trail"),
                      TrailListDropDown(
                        selectedTrail: selectedTrail,
                        trails: state.trails,
                        onChanged: (selected) {
                          setState(() {
                            selectedTrail = selected;
                          });
                        },
                      ),
                    ],
                  ),
                ),
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
                                controller: dateController,
                                enabled: selectedTrail != null,
                                onSubmit: (value) {
                                  if (value is DateTime) {
                                    chosenDate = value;
                                    log(chosenDate.toString());
                                    dateController.text =
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
                            const Text('Time'),
                            TextFormField(),
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
                      TextFormField(),
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
                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                            child: TextFormField(
                              enabled: false,
                              controller: TextEditingController(text: '+63'),
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: kVerticalPadding,
                          ),
                          Expanded(
                            flex: 8,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: '9** *** ****',
                                counterText: '', // hide the counter text at the bottom
                              ),
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
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
                      TextFormField(),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledTextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        log('selected trail: ${selectedTrail?.difficulty.name}');
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

class BookingDatePicker extends StatelessWidget {
  const BookingDatePicker({
    Key? key,
    this.enabled = false,
    required this.controller,
    required this.onSubmit,
  }) : super(key: key);

  final bool enabled;
  final TextEditingController controller;
  final void Function(Object?) onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomDatePicker(
                enablePastDates: false,
                minDate: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day + 3,
                ),
                onSumbit: onSubmit,
              ),
            );
          },
        );
      },
      decoration: InputDecoration(
        hintText: 'Choose Date',
        prefixIcon: Icon(
          Icons.calendar_today_outlined,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
