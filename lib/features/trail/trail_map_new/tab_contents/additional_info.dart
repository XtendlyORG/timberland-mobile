import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/themes/timberland_color.dart';

class AdditionalInfo extends StatelessWidget {
  final String selectedTrail;
  const AdditionalInfo({super.key, required this.selectedTrail});

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
          child: Align(
            alignment: Alignment.topCenter,
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
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: (MediaQuery.of(context).size.height * 0.4) - 40,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //info 1
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Center(
                                child: Image.asset(
                                  'assets/trail_map/arrowsWhite.png',
                                  width: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: const Text(
                                  'Directional arrows. Trails are one way unless specified.'),
                            )
                          ],
                        ),
                        //info 2
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Center(
                                child: Image.asset(
                                  'assets/trail_map/greenDots.png',
                                  width: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: const Text(
                                  'Green dots indicate the recommended route for first-time visitors to TMBP.'),
                            )
                          ],
                        ),
                        //info 3
                        Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Center(
                                child: Image.asset(
                                  'assets/trail_map/yellowCircleIcon.png',
                                  width: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: const Text(
                                  'Wayfinders contain directional information and also indicate when trails merge or branch out.'),
                            )
                          ],
                        ),
                        //info 4
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Center(
                                child: Image.asset(
                                  'assets/trail_map/CameraIcons.png',
                                  width: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: const Text(
                                  'Points of interest, rest stops & designated photo spots. These locations also contain airhorns for emergency signalling'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // //Redirect Button
                        // selectedTrail == ''
                        //     ? SizedBox()
                        //     : InkWell(
                        //         onTap: () {
                        //           print('dasdadas');
                        //           // List<Trail> trailList = state.trails
                        //           //     .where((e) =>
                        //           //         e.trailName
                        //           //             .toString()
                        //           //             .toLowerCase() ==
                        //           //         selectedTrail.toLowerCase())
                        //           //     .toList();
                        //           // Trail trail = trailList[0];
                        //           // context.pushNamed(
                        //           //   Routes.specificTrail.name,
                        //           //   params: {
                        //           //     'id': trail.trailId,
                        //           //   },
                        //           //   extra: trail,
                        //           // );
                        //         },
                        //         child: Card(
                        //           color: Colors.transparent,
                        //           elevation: 20,
                        //           child: Container(
                        //             width: 200,
                        //             height: 40,
                        //             decoration: BoxDecoration(
                        //                 color: TimberlandColor.primary,
                        //                 border: Border.all(color: Colors.black),
                        //                 borderRadius:
                        //                     BorderRadius.circular(20)),
                        //             child: Center(
                        //               child: Text(
                        //                 'View $selectedTrail',
                        //                 style: const TextStyle(
                        //                     color: Colors.white),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       )
                      ]),
                ),
              ],
            ),
          )),
    );
  }
}
