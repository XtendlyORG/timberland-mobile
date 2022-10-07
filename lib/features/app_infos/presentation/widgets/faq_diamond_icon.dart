import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/faq_icon_wrapper.dart';

class FaqDiamondIcon extends StatelessWidget {
  final int count;
  const FaqDiamondIcon({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
          count,
          (_) => Transform.rotate(
                angle: pi / 4,
                child: const FaqIconWrapper(
                  icon: Icon(
                    Icons.square,
                    color: Colors.black,
                  ),
                ),
              )),
    );
  }
}
