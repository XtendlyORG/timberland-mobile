import 'package:flutter/material.dart';

class TrailWidget extends StatelessWidget {
  final String ascent;
  final String decent;
  final String difficulty;
  final String distance;
  final String name;
  const TrailWidget(
      {super.key,
      required this.name,
      required this.ascent,
      required this.decent,
      required this.difficulty,
      required this.distance});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    Color textColor = Colors.white;
    switch (difficulty.toLowerCase()) {
      case 'intermediate':
        backgroundColor = Colors.green;
        textColor = Colors.white;
        break;
      case 'novice':
        backgroundColor = Colors.white;
        textColor = Colors.green;
        break;
      case 'expert':
        backgroundColor = Colors.black;
        textColor = Colors.white;
        break;
      case 'advance':
        backgroundColor = const Color.fromARGB(255, 2, 46, 165);
        textColor = Colors.white;
        break;
      default:
    }

    return Container(
      height: 55,
      width: 175,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              width: 2,
              color: difficulty.toLowerCase() == 'novice'
                  ? Colors.green
                  : Colors.white)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                //distance
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_right_sharp,
                        size: 25,
                        color: textColor,
                      ),
                      Text(
                        distance,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 11),
                      )
                    ],
                  ),
                ),
                //ascending
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_drop_up_sharp,
                        size: 25,
                        color: textColor,
                      ),
                      Text(
                        ascent,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 11),
                      )
                    ],
                  ),
                ),
                //descending
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 25,
                        color: textColor,
                      ),
                      Text(
                        decent,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 11),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
