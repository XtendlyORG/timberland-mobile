import 'package:flutter/widgets.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class AnimatedCircularSplash extends StatelessWidget {
  const AnimatedCircularSplash({
    super.key,
    required this.controller,
    required this.radius,
  });
  final AnimationController controller;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * (1 + controller.value),
      height: radius * (1 + controller.value),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: TimberlandColor.secondaryColor.withOpacity(
          1 - controller.value,
        ),
      ),
    );
  }
}
