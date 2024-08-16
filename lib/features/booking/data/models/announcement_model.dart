import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AnnouncementModel {
  int? id;
  String? image;
  String? title;
  String? content;
  String? pushDateTime;
  String? expiredDateTime;
  bool? visibility;
  bool? isExpired;
  XFile? imageFile;
  int? order;

  AnnouncementModel({
    this.id,
    this.image,
    this.title,
    this.content,
    this.pushDateTime,
    this.expiredDateTime,
    this.visibility,
    this.isExpired,
    this.imageFile,
    this.order,
  });

  AnnouncementModel.fromJson(Map<String, dynamic> json){
    try {
      id = json['id'];
      title = json['title'];
      content = json ['content'];
      image = json['image'];
      pushDateTime = json['start_datetime'];
      expiredDateTime = json['end_datetime'];
      visibility = json['visibility'] == 1;
      isExpired = json['is_expired'] != null;
      order = json['order'];
    } catch (e) {
      debugPrint("Error model ${e.toString()}");
    }
  }
}
