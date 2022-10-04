// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';
import 'package:timberland_biketrail/core/presentation/widgets/dialogs/custom_dialog.dart';
import 'package:timberland_biketrail/dashboard/presentation/bloc/profile_bloc.dart';

class DiscardUpdatesDialog extends StatelessWidget {
  final String promptMessage;
  const DiscardUpdatesDialog({
    Key? key,
    required this.promptMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      content: Padding(
        padding: const EdgeInsets.only(
          top: kVerticalPadding,
          left: kVerticalPadding,
          right: kVerticalPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kVerticalPadding,
              ),
              child: Text(
                promptMessage,
                style: const TextStyle(fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
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
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                        BlocProvider.of<ProfileBloc>(context)
                            .add(const CancelUpdateRequest());
                      },
                      child: const Text(
                        'Discard',
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
  }
}
