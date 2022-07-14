// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FAQ extends Equatable {
  final String faqId;
  final String question;
  final String answer;
  const FAQ({
    required this.faqId,
    required this.question,
    required this.answer,
  });

  @override
  List<Object> get props => [faqId, question, answer];
}
