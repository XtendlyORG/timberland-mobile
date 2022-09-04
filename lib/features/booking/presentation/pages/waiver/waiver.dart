import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_styled_text.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/faq_widget.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/waiver/waiver_content.dart';

class BookingWaiver extends StatelessWidget {
  const BookingWaiver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TimberlandScaffold(
        titleText: 'Waiver',
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kVerticalPadding,
            vertical: kHorizontalPadding,
          ),
          child: Container(
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
                      "${Session().currentUser!.firstName} ${Session().currentUser!.lastName}",
                    ),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
