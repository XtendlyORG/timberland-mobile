import 'dart:ui';

import 'package:flutter/material.dart';

class TrailProgression extends StatelessWidget {
  const TrailProgression({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(24, 255, 255, 255),
              Color.fromARGB(45, 255, 255, 255),
              Color.fromARGB(69, 255, 255, 255),
              Color.fromARGB(120, 255, 255, 255),
              Color.fromARGB(171, 255, 255, 255).withOpacity(.60),
              Colors.white.withOpacity(.225)
            ],
          ),
        ),
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          children: [
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Container(
                  color: Color.fromARGB(24, 255, 255, 255),
                  height: 40,
                  width: MediaQuery.of(context).size.width * 1,
                ),
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height * 0.4) - 40,
              child: Center(
                child: SizedBox(
                  width: 350,
                  child: Image.asset(
                    'assets/trail_map/progression.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
