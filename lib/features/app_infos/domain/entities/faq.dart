// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class FAQ extends Equatable {
  final String question;
  final String? answer;
  final Widget? icon;
  final List<FAQ>? subCategory;
  const FAQ({
    required this.question,
    this.answer,
    this.icon,
    this.subCategory,
  });

  @override
  List<Object> get props => [question];
}
