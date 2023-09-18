import 'package:flutter/material.dart';

class CustomMap extends StatefulWidget {
  final TransformationController controller;
  const CustomMap({Key? key, required this.controller}) : super(key: key);

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  TapDownDetails? tapDownDetails;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: AspectRatio(
            aspectRatio: 1,
            child: InteractiveViewer(
              transformationController: widget.controller,
              panEnabled: true, // Set it to false
              minScale: 0.5,
              maxScale: 4.0,
              child: Container(
                height: 1080,
                width: 1080,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/trail_map/TMBPMAPFINALPOI082023.png')),
                ),
              ),
            ),
          ),
        ),
        // TextButton(
        //     onPressed: () {
        //       // controller.toScene(Offset((0.228 * Coordinatest.billAndTed.x),
        //       //     (0.228 * Coordinatest.billAndTed.x)));
        //       final position = tapDownDetails!.localPosition;

        // double scale = 3;
        // final x = -position.dx * (scale - 1);
        // final y = -position.dy * (scale - 1);
        // print({x, y});
        // final zoomed = Matrix4.identity()
        //   ..translate(-535.8, -696.76)
        //   ..scale(scale);
        // final value = zoomed;
        // controller.value = value;
        //     },
        //     child: const Text('Pan to Viper')),
      ],
    );
  }
}
