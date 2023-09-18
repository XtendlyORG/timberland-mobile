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
          color: TimberlandColor.background,
          width: MediaQuery.of(context).size.width * 1,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 300,
              width: 420,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //info 1
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: Center(
                            child: Image.asset(
                              'assets/trail_map/arrowsWhite.png',
                              width: 50,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                          width: 320,
                          child: Center(
                            child: Text(
                                'Directional arrows. Trails are one way unless specified.'),
                          ),
                        )
                      ],
                    ),
                    //info 2
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: Center(
                            child: Image.asset(
                              'assets/trail_map/greenDots.png',
                              width: 50,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                          width: 320,
                          child: Center(
                            child: Text(
                                'Green dots indicate the recommended route for first-time visitors to TMBP.'),
                          ),
                        )
                      ],
                    ),
                    //info 3
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 100,
                          child: Center(
                            child: Image.asset(
                              'assets/trail_map/yellowCircleIcon.png',
                              width: 50,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                          width: 320,
                          child: Center(
                            child: Text(
                                'Wayfinders contain directional information and also indicate when trails merge or branch out.'),
                          ),
                        )
                      ],
                    ),
                    //info 4
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: Center(
                            child: Image.asset(
                              'assets/trail_map/CameraIcons.png',
                              width: 50,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                          width: 320,
                          child: Center(
                            child: Text(
                                'Points of interest, rest stops & designated photo spots. These locations also contain airhorns for emergency signalling'),
                          ),
                        )
                      ],
                    ),
                    //Redirect Button
                    selectedTrail == ''
                        ? SizedBox()
                        : InkWell(
                            onTap: () {},
                            child: Card(
                              color: Colors.transparent,
                              elevation: 20,
                              child: Container(
                                width: 200,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: TimberlandColor.primary,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    'View $selectedTrail',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                  ]),
            ),
          )),
    );
  }
}
