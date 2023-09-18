import 'package:flutter/material.dart';
import 'package:timberland_biketrail/features/trail/trail_map_new/custom_map.dart';
import 'package:timberland_biketrail/features/trail/trail_map_new/tab_bar.dart';

import 'tab_contents/additional_info.dart';
import 'tab_contents/trail_directory.dart';
import 'tab_contents/trail_progression.dart';

class CustomMapPage extends StatefulWidget {
  const CustomMapPage({Key? key}) : super(key: key);

  @override
  State<CustomMapPage> createState() => _CustomMapPageState();
}

class _CustomMapPageState extends State<CustomMapPage> {
  int _currentIndex = 0;
  String selectedTrail = '';
  late TransformationController _controller;

  @override
  void initState() {
    _controller = TransformationController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void selectTrail(String trail) {
      setState(() {
        selectedTrail = trail;
      });
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: <Widget>[
          CustomMap(
            controller: _controller,
          ),
          Positioned(
            bottom: 20,
            child: SizedBox(
              height: 410,
              child: Column(
                children: [
                  MapTabBar(
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    selectedTrail: selectedTrail,
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _currentIndex,
                      children: [
                        TrailDirectory(
                          controller: _controller,
                          selectTrail: selectTrail,
                        ),
                        const TrailProgression(),
                        AdditionalInfo(
                          selectedTrail: selectedTrail,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
