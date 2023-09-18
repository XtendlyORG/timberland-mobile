import 'package:flutter/material.dart';

class TrailProgression extends StatelessWidget {
  const TrailProgression({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 1,
        child: Center(
          child: SizedBox(
            width: 350,
            child: Image.asset(
              'assets/trail_map/progression.png',
            ),
          ),
        ),
      ),
    );
  }
}
