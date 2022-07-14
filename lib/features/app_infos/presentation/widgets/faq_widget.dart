// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _controller.addListener(() {
      setState(() {
        _angle = _controller.value * 45 / 360 * pi * 2;
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
        },
        title: Text(widget.faq.question),
        trailing: FAQTrailing(
          angle: _angle,
        ),
        childrenPadding: const EdgeInsets.only(
          left: kHorizontalPadding,
          right: kVerticalPadding,
          bottom: kVerticalPadding,
        ),
        children: [
          Text(
            widget.faq.answer,
            textAlign: TextAlign.justify,
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
