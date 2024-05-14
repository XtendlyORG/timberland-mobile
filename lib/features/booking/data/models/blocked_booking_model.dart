// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

class BlockedBookingsModel {
  int? bookingId;
  DateTime? startDate;
  DateTime? endDate;
  String? reasonContent;
  String? status;
  bool? isBlocked;

  BlockedBookingsModel(
      {this.bookingId,
      this.startDate,
      this.endDate,
      this.reasonContent,
      this.status,
      this.isBlocked});

  BlockedBookingsModel.fromJson(Map<String, dynamic> json) {
    bookingId = json['id'];
    final tempStartDate = DateTime.tryParse(json['start_date']);
    startDate = tempStartDate != null
      ? DateTime(tempStartDate.year, tempStartDate.month, tempStartDate.day)
      : null;
    final tempEndDate = DateTime.tryParse(json['end_date']);
    endDate = tempEndDate != null
      ? DateTime(tempEndDate.year, tempEndDate.month, tempEndDate.day)
      : null;
    reasonContent = json['reason'];
    // status = json['status'];
    status = DateTime(tempEndDate?.year ?? DateTime.now().year, tempEndDate?.month ?? DateTime.now().month, tempEndDate?.day ?? DateTime.now().day).add(const Duration(hours: 23)).millisecondsSinceEpoch > DateTime.now().millisecondsSinceEpoch
      ? json['is_blocked'] == 1
          ? "Active"
          : "Unblocked"
      : "Expired";
    isBlocked = json['is_blocked'] == 1;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['booking_id'] = bookingId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['reason'] = reasonContent;
    data['status'] = status;
    data['is_blocked'] = isBlocked;
    return data;
  }

  List<dynamic> toRow() {
    return [
      bookingId,
      startDate,
      endDate,
      reasonContent,
      isBlocked,
    ];
  }
}
