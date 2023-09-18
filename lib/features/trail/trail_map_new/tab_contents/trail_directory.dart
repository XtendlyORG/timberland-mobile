import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/themes/timberland_color.dart';
import '../data/trail_coordinates.dart';
import '../data/trails_model.dart';
import '../widgets/trail_widget.dart';

class TrailDirectory extends StatefulWidget {
  final TransformationController controller;
  final Function selectTrail;
  const TrailDirectory(
      {super.key, required this.controller, required this.selectTrail});

  @override
  State<TrailDirectory> createState() => _TrailDirectoryState();
}

class _TrailDirectoryState extends State<TrailDirectory> {
  List<TrailsModel> trailList = [];
  @override
  void initState() {
    super.initState();
    getTrails();
  }

  Future<void> getTrails() async {
    final String response =
        await rootBundle.loadString('assets/trail_map/trails.json');
    final data = await json.decode(response);
    final List<dynamic> trails = data['result'];
    setState(() {
      trailList =
          trails.map((dynamic item) => TrailsModel.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /////INFO???
        Container(
          width: MediaQuery.of(context).size.width * .49,
          decoration: const BoxDecoration(
            // color: TimberlandColor.background,
            color: TimberlandColor.background,
          ),
          child: Column(children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * .50,
              child: const Center(
                  child: Text(
                'INFO',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            const SizedBox(height: 10),

            /// SIGN GUIDE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Sign Guide:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  'assets/trail_map/trailguide.png',
                  width: 100,
                ),
              ],
            ),

            /// SKILL LEVEL
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'SKILL LEVEL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //NOVICE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  child: const Text(
                    'NOVICE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(color: Colors.green)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //INTERMEDIATE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  child: const Text(
                    'INTERMEDIATE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //ADVANCE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  child: const Text(
                    'ADVANCE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 2, 46, 165),
                      border: Border.all(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //EXPRRT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  child: const Text(
                    'EXPERT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Transform.rotate(
                  angle: 45 *
                      3.14159265359 /
                      180, // Rotate 45 degrees (in radians)
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),

        ///DIVIDER//
        Container(
          color: TimberlandColor.background,
          width: MediaQuery.of(context).size.width * 0.02,
          child: Center(
              child: Container(
            width: 5,
            height: 250,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          )),
        ),
        /////TRAILS
        Container(
          width: MediaQuery.of(context).size.width * .49,
          decoration: const BoxDecoration(color: TimberlandColor.background),
          child: Column(children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * .50,
              child: const Center(
                  child: Text(
                'TRAILS',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),

            //Trail Widgets
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 260,
              width: 200,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: trailList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              double scale = 3;
                              widget.selectTrail(
                                  trailList[index].name.toString());
                              final zoomed = Matrix4.identity()
                                ..translate(
                                    Coordinates.values
                                        .byName(trailList[index]
                                            .coordinates
                                            .toString())
                                        .x,
                                    Coordinates.values
                                        .byName(trailList[index]
                                            .coordinates
                                            .toString())
                                        .y)
                                ..scale(scale);
                              final value = zoomed;
                              widget.controller.value = value;
                            },
                            child: TrailWidget(
                                name: trailList[index].name.toString(),
                                ascent: trailList[index].ascent.toString(),
                                decent: trailList[index].decent.toString(),
                                difficulty:
                                    trailList[index].difficulty.toString(),
                                distance: trailList[index].distance.toString()),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    }),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
