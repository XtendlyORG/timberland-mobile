// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_styled_text.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/faq.dart';

class FAQWidget extends StatefulWidget {
  const FAQWidget({
    Key? key,
    required this.faq,
  }) : super(key: key);
  final FAQ faq;

  @override
  State<FAQWidget> createState() => _FAQWidgetState();
}

class _FAQWidgetState extends State<FAQWidget> with TickerProviderStateMixin {
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          style: BorderStyle.solid,
        ),
      ),
      child: ExpansionTile(
        onExpansionChanged: (isExpanded) {
          isExpanded ? _controller.forward() : _controller.reverse();
          setState(() {
            _isExpanded = isExpanded;
          });
        },
        title: AutoSizeText(
          widget.faq.question,
          maxLines: _isExpanded ? 10 : 2,
          minFontSize: Theme.of(context).textTheme.titleSmall!.fontSize!,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: FAQTrailing(
          angle: _angle,
        ),
        childrenPadding: const EdgeInsets.only(
          left: kVerticalPadding,
          right: kVerticalPadding,
          bottom: kVerticalPadding,
        ),
        children: [
          CustomStyledText(
            text: widget.faq.answer,
          ),
        ],
      ),
    );
  }
}

class FAQTrailing extends StatelessWidget {
  const FAQTrailing({
    Key? key,
    required this.angle,
  }) : super(key: key);

  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: const Icon(
        Icons.add,
        // size: 50,
      ),
    );
  }
}
