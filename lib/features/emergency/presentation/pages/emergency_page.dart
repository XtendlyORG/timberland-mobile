import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/timberland_scaffold.dart';
import '../../../../core/themes/timberland_color.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TimberlandScaffold(
      titleText: "Emergency",
      body: Padding(
        padding: const EdgeInsets.all(kHorizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: AnimatedBuilder(
                animation: CurvedAnimation(
                    parent: _controller, curve: Curves.fastLinearToSlowEaseIn),
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      // _buildContainer(50 * (1 + _controller.value)),
                      _buildContainer(100 * (1 + _controller.value)),
                      _buildContainer(120 * (1 + _controller.value)),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: TimberlandColor.secondaryColor),
                        padding: const EdgeInsets.all(kHorizontalPadding),
                        child: const Image(
                          image: AssetImage('assets/icons/emergency-icon.png'),
                          height: 64,
                          width: 64,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Text(
              'After pressing the emergency button, we will contact our nearest admin station to your current location.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            TimberlandColor.secondaryColor.withOpacity(1 - _controller.value),
      ),
    );
  }
}
