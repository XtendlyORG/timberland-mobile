// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/features/history/presentation/bloc/history_bloc.dart';
import 'package:timberland_biketrail/features/history/presentation/widgets/cancel_booking/cancel_booking_dialog.dart';
import 'package:timberland_biketrail/features/history/presentation/widgets/inherited_booking.dart';

import '../../../../../core/constants/padding.dart';
import '../../../../../core/presentation/widgets/widgets.dart';

class CancellationReasonPicker extends StatefulWidget {
  const CancellationReasonPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<CancellationReasonPicker> createState() =>
      _CancellationReasonPickerState();
}

class _CancellationReasonPickerState extends State<CancellationReasonPicker> {
  String? reason;
  late final TextEditingController otherReasonCtrl;
  late bool textFieldEnabled;
  final reasons = [
    'Change of mind',
    'Weather reasons',
    "Change of booking date",
    'Others (Please specify):',
  ];
  @override
  void initState() {
    super.initState();
    textFieldEnabled = false;
    otherReasonCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...reasons.map((e) {
          if (e.contains('Others')) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  value: otherReasonCtrl.text,
                  title: Text(
                    e,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  groupValue: reason,
                  onChanged: (val) {
                    textFieldEnabled = true;
                    setState(() {
                      reason = val as String;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kHorizontalPadding * 1.75,
                    right: kVerticalPadding * 1.5,
                    bottom: kVerticalPadding,
                  ),
                  child: TextFormField(
                    controller: otherReasonCtrl,
                    enabled: textFieldEnabled,
                    maxLines: 2,
                    maxLength: 255,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Field can not be empty.'
                        : null,
                  ),
                ),
              ],
            );
          }
          return RadioListTile(
            value: e,
            title: Text(
              e,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            groupValue: reason,
            onChanged: (val) {
              if (textFieldEnabled) textFieldEnabled = false;
              setState(() {
                reason = val as String;
              });
            },
          );
        }).toList(),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              left: kVerticalPadding * 1.5,
              right: kVerticalPadding * 1.5,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: FilledTextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CancelBookingDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "When you cancel a booking, you will get a free pass that you can consume within four months.",
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Are you sure you want to cancel this booking?",
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ).then((value) {
                  if (value is bool && value) {
                    textFieldEnabled ? reason = otherReasonCtrl.text : reason;

                    BlocProvider.of<HistoryBloc>(context).add(
                      CancelBookingEvent(
                        bookingId: InheritedBooking.of(context).booking.id,
                        reason: reason ?? "Not Specified",
                      ),
                    );
                  }
                  Navigator.pop(context);
                });
              },
              child: const Text(
                'Confirm',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
