import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTime(TimeOfDay? time, {String? defaultText}) {
  if (time == null) return defaultText ?? 'N/A';
  return DateFormat('hh:mm a').format(
    DateTime(
      0,
      0,
      0,
      time.hour,
      time.minute,
    ),
  );
}

TimeOfDay stringToTime(String formattedTime) {
  final parsedTime = formattedTime.split(':');
  return TimeOfDay(
    hour: int.parse(parsedTime[0]),
    minute: int.parse(
      parsedTime[1],
    ),
  );
}
