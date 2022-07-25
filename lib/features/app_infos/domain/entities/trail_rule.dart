// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';


class TrailRule extends Equatable {
  final String note;
  const TrailRule({
    required this.note,
  });

  @override
  List<Object> get props => [
        note,
      ];
}
