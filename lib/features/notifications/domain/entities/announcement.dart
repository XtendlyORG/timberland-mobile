// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Announcement extends Equatable {
  final String title;
  final String content;
  final DateTime dateCreated;
  final DateTime? updatedAt;
  final String id;
  const Announcement({
    required this.title,
    required this.content,
    required this.dateCreated,
    this.updatedAt,
    required this.id,
  });

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      dateCreated: DateTime.parse(map['created_at']),
      id: map['id'].toString(),
    );
  }

  @override
  List<Object> get props => [title, content, dateCreated, id];
}
