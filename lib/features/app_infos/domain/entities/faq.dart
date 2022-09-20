// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FAQ extends Equatable {
  final String question;
  final String? answer;
  final List<FAQ>? subCategory;
  const FAQ({
    required this.question,
    this.answer,
    this.subCategory,
  });

  @override
  List<Object> get props => [question];
}
