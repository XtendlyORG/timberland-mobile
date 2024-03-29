// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_styled_text.dart';
import 'package:timberland_biketrail/core/presentation/widgets/dialogs/custom_dialog.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/validators/non_empty_validator.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
import 'package:timberland_biketrail/features/booking/presentation/cubit/free_pass_counter_cubit.dart';
import 'package:timberland_biketrail/features/booking/presentation/widgets/booking_date_picker.dart';
import 'package:timberland_biketrail/features/booking/presentation/widgets/booking_time_picker.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../bloc/booking_bloc.dart';

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
  late bool waiverAccepted;
  late final GlobalKey<FormState> formKey;
  late DateTime? selectedDate;
  late TimeOfDay? selectedTime;
  late TextEditingController dateCtrl;
  late TextEditingController timeCtrl;
  late TextEditingController mobileNumberCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController firstNameCtrl;
  late TextEditingController lastNameCtrl;

  @override
  void initState() {
    waiverAccepted = false;
    formKey = GlobalKey<FormState>();
    selectedDate = null;
    selectedTime = null;
    dateCtrl = TextEditingController();
    timeCtrl = TextEditingController();
    mobileNumberCtrl = TextEditingController(text: widget.user.mobileNumber);
    emailCtrl = TextEditingController(
      text: widget.user.email,
    );
    firstNameCtrl = TextEditingController(
      text: widget.user.firstName,
    );
    lastNameCtrl = TextEditingController(
      text: widget.user.lastName,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is SubmittingBookingRequest) {
          showLoading('Processing...');
        }
        if (state is BookingError) {
          if (state is DuplicateBookingError) {
            _showBookingDialog(
              context,
              text:
                  "You already have a booking schedule for that date. Please try to book on a different date.",
              onPop: () {},
            );
          } else {
            showError(state.errorMessage);
          }
        }
        if (state is BookingSubmitted) {
          EasyLoading.dismiss();
          if (state.isFree) {
            BlocProvider.of<FreePassCounterCubit>(context).decrement();
            showSuccess('Free booking completed');
            Navigator.pop(context);
          } else {
            context.goNamed(Routes.checkout.name);
          }
        }
      },
      child: BlocBuilder<FreePassCounterCubit, int?>(
        builder: (context, freePassCount) {
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
                                selectedTime: selectedTime,
                                enabled: true,
                                onSubmit: (value) {
                                  if (value is DateTime) {
                                    setState(() {
                                      selectedDate = value;
                                    });
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
                                controller: timeCtrl,
                                selectedDate: selectedDate,
                                enabled: selectedDate != null,
                                onSubmit: (value) {
                                  if (value is TimeOfDay) {
                                    setState(() {
                                      selectedTime = value;
                                    });
                                  }
                                },
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("First Name"),
                            TextFormField(
                              controller: firstNameCtrl,
                              decoration: const InputDecoration(
                                hintText: "First Name",
                              ),
                              validator: (fullName) {
                                return nonEmptyValidator(
                                  fullName,
                                  errorMessage: 'First Name can not be empty.',
                                );
                              },
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
                            const Text("Last Name"),
                            TextFormField(
                              controller: lastNameCtrl,
                              decoration: const InputDecoration(
                                hintText: "Last Name",
                              ),
                              validator: (fullName) {
                                return nonEmptyValidator(
                                  fullName,
                                  errorMessage: 'Last Name can not be empty.',
                                );
                              },
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
                      const Text('Mobile Number'),
                      MobileNumberField(
                        controller: mobileNumberCtrl,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: kVerticalPadding / 2,
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
                const SizedBox(
                  height: kVerticalPadding,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledTextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (freePassCount != null && freePassCount > 0) {
                          _showBookingDialog(
                            context,
                            text:
                                'You have a FREE Pass. Your set booking at <bold>${DateFormat('MMM dd, yyyy').format(selectedDate!)}</bold> will be free.',
                            isDecisionTypeActions: true,
                            onPop: () {
                              onSumbit(context);
                            },
                          );
                        } else {
                          onSumbit(context);
                        }
                      }
                    },
                    child: freePassCount != null && freePassCount > 0
                        ? Text('Free Booking (x$freePassCount)')
                        : const Text("Submit"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void onSumbit(BuildContext context) {
    context.pushNamed(
      Routes.bookingWaiver.name,
      extra: BookingRequestParams(
        firstName: firstNameCtrl.text,
        lastName: lastNameCtrl.text,
        mobileNumber: mobileNumberCtrl.text,
        email: emailCtrl.text,
        date: selectedDate.toString().split(' ')[0],
        time: DateTime(
          0,
          0,
          0,
          selectedTime!.hour,
          selectedTime!.minute,
        ).toString().split(' ')[1],
      ),
    );
  }

  void _showBookingDialog(
    BuildContext context, {
    required String text,
    required VoidCallback onPop,
    bool isDecisionTypeActions = false,
  }) {
    EasyLoading.dismiss();
    showDialog(
      context: context,
      builder: (ctx) {
        return CustomDialog(
          content: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kVerticalPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: kHorizontalPadding,
                ),
                CustomStyledText(
                  text: text,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: kVerticalPadding + 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (isDecisionTypeActions) ...[
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'CANCEL',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: VerticalDivider(
                            thickness: 1.5,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ],
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text(
                            'OKAY',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      if (value is bool && value) {
        onPop();
      }
    });
  }
}
