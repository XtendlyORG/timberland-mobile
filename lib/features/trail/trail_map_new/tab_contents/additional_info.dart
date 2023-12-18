import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/constants/signages.dart';

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
                const Color.fromARGB(24, 255, 255, 255),
                const Color.fromARGB(45, 255, 255, 255),
                const Color.fromARGB(69, 255, 255, 255),
                const Color.fromARGB(120, 255, 255, 255),
                const Color.fromARGB(171, 255, 255, 255).withOpacity(.60),
                Colors.white.withOpacity(.225)
              ],
            ),
          ),
          width: MediaQuery.of(context).size.width * 1,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                      child: Container(
                        color: const Color.fromARGB(24, 255, 255, 255),
                        height: 40,
                        width: MediaQuery.of(context).size.width * 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    height: (MediaQuery.of(context).size.height * 0.4) - 40,
                    child: ListView.separated(
                        itemCount: signages.length,
                        padding: const EdgeInsets.all(0),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Center(
                                  child: Image.asset(
                                    signages[index].imgPath,
                                    width: 50,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text("${signages[index].name} - ${signages[index].description}"),
                              )
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
