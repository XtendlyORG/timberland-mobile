import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

bool dateIsWithinRange(DateTime myDate, DateTime? startDate, DateTime? endDate) {
  return (myDate.isAfter(startDate ?? DateTime.now()) && myDate.isBefore(endDate ?? DateTime.now())) || myDate.toString().substring(0, 10) == startDate?.toString().substring(0, 10) || myDate.toString().substring(0, 10) == endDate?.toString().substring(0, 10);
}

DateTime? findEarliestDate(List<DateTime> dates) {
  if (dates.isEmpty) return null;
  return dates.reduce((min, date) => min.isBefore(date) ? min : date);
}

DateTime? findLatestDate(List<DateTime> dates) {
  if (dates.isEmpty) return null;
  return dates.reduce((max, date) => max.isAfter(date) ? max : date);
}

String removeHtmlTags(String htmlText) {
  return Bidi.stripHtmlIfNeeded(htmlText);
}