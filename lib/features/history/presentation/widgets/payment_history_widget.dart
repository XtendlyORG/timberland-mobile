// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/core/utils/format_time.dart';
import 'package:timberland_biketrail/core/utils/string_extensions.dart';
import 'package:timberland_biketrail/features/history/domain/entities/entities.dart';

import '../../../../core/constants/constants.dart';

class PaymentHistoryWidget extends StatelessWidget {
  final PaymentHistory payment;
  const PaymentHistoryWidget({
    Key? key,
    required this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AutoSizeGroup autoSizeGroup = AutoSizeGroup();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(kVerticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AutoSizeText(
                  group: autoSizeGroup,
                  DateFormat('dd MMMM yyyy').format(
                    payment.dateCreated,
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.normal),
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: kVerticalPadding),
              Expanded(
                child: AutoSizeText(
                  group: autoSizeGroup,
                  'PHP ${payment.amount % 1 == 0 ? payment.amount.toInt() : payment.amount}',
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AutoSizeText(
              group: autoSizeGroup,
              formatTime(
                TimeOfDay(
                  hour: payment.dateCreated.hour,
                  minute: payment.dateCreated.minute,
                ),
              ),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Maya_logo.svg/1200px-Maya_logo.svg.png',
                    // width: 56,
                    height: double.infinity,
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const Spacer(),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: AutoSizeText(
                    payment.status.name.toTitleCase(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.normal,
                          color: payment.status == PaymentStatus.successful
                              ? Colors.green
                              : TimberlandColor.secondaryColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const Text('Reference Number:'),
          SelectableRegion(
            focusNode: FocusNode(),
            selectionControls: materialTextSelectionControls,
            child: Tooltip(
              message: 'Press and hold to copy',
              triggerMode: TooltipTriggerMode.tap,
              child: AutoSizeText(
                payment.refNum,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                maxLines: 2,
                presetFontSizes: const [14],
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
