// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_checkbox.dart';
import 'package:timberland_biketrail/core/presentation/widgets/dialogs/custom_dialog.dart';
import 'package:timberland_biketrail/core/presentation/widgets/snackbar_content/loading_snackbar_content.dart';
import 'package:timberland_biketrail/core/presentation/widgets/snackbar_content/show_snackbar.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/core/utils/validators/non_empty_validator.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
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
          showSnackBar(
            const SnackBar(
              content: LoadingSnackBarContent(loadingMessage: 'Processing...'),
            ),
          );
        }
        if (state is BookingError) {
          showSnackBar(
            SnackBar(
              content: AutoSizeText(state.errorMessage),
            ),
          );
        }
        if (state is BookingSubmitted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          if (state.isFree) {
            _showFreeBookingDialog(context, onPop: () {
              context.pushNamed(Routes.bookingHistory.name);
            });
          } else {
            context.pushNamed(Routes.checkout.name);
          }
        }
      },
      child: Form(
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
                                selectedDate = value;
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
                            enabled: true,
                            onSubmit: (value) {
                              if (value is TimeOfDay) {
                                selectedTime = value;
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
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomCheckbox(
                    onChange: (val) {
                      waiverAccepted = val;
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.5),
                      child: Text.rich(
                        style: Theme.of(context).textTheme.labelLarge,
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'I, hereby declare that I understand the ',
                            ),
                            TextSpan(
                              text: 'nature and conditions ',
                              style: const TextStyle(
                                color: TimberlandColor.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushNamed(Routes.bookingWaiver.name);
                                },
                            ),
                            const TextSpan(
                              text:
                                  'of the "Timberland Mountain Bike Park" within Timberland Heights grounds and premises (hereafter the "Premises").',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledTextButton(
                onPressed: () {
                  if (!waiverAccepted) {
                    showSnackBar(const SnackBar(
                        content: AutoSizeText("Waiver not accepted.")));
                    return;
                  }
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<BookingBloc>(context).add(
                      SubmitBookingRequest(
                        params: BookingRequestParams(
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
                      ),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFreeBookingDialog(
    BuildContext context, {
    required VoidCallback onPop,
  }) {
    showDialog(
      context: context,
      builder: (ctx) {
        return CustomDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: kHorizontalPadding,
              ),
              const Text(
                'This booking is free',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: kVerticalPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Okay'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then((value) {
      onPop();
    });
  }
}
