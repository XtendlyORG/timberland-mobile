// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/router/routes.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/booking/data/models/announcement_model.dart';
import 'package:timberland_biketrail/features/constants/helpers.dart';

class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final AnnouncementModel data;

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  double _angle = 0;
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _isExpanded = false;
    _controller.addListener(() {
      setState(() {
        _angle = _controller.value * 45 / 360 * math.pi * 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.announcementsView.name,
          extra: widget.data
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              style: BorderStyle.solid,
            ),
            color: TimberlandColor.background),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              widget.data.title ?? "",
              minFontSize: Theme.of(context).textTheme.titleLarge!.fontSize!,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.left,
            ),
            AutoSizeText(
              (widget.data.content ?? "Welcome to Timberland Mountain Bike Park Mobile").split("\n").isNotEmpty
                ? removeHtmlTags((widget.data.content ?? "Welcome to Timberland Mountain Bike Park Mobile").split("\n").first)
                : removeHtmlTags((widget.data.content ?? "Welcome to Timberland Mountain Bike Park Mobile")),
              maxLines: 1,
              minFontSize: Theme.of(context).textTheme.titleSmall!.fontSize!,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.left,
            ),
          ],
        )
        // Theme(
        //   data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        //   child: ExpansionTile(
        //     onExpansionChanged: (isExpanded) {
        //       isExpanded ? _controller.forward() : _controller.reverse();
        //       setState(() {
        //         _isExpanded = isExpanded;
        //       });
        //     },
        //     title: AutoSizeText(
        //       widget.faq.title ?? "",
        //       maxLines: _isExpanded ? 10 : 2,
        //       minFontSize: Theme.of(context).textTheme.titleSmall!.fontSize!,
        //       overflow: TextOverflow.ellipsis,
        //       style: Theme.of(context).textTheme.titleSmall,
        //     ),
        //     leading: const SizedBox(),
        //     trailing: const SizedBox(),
        //     childrenPadding: const EdgeInsets.only(
        //       left: kVerticalPadding,
        //       right: kVerticalPadding,
        //       bottom: kVerticalPadding,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
