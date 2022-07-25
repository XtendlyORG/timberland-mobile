// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';

class InheritedTrail extends InheritedWidget {
  final Trail? trail;
  const InheritedTrail({
    required super.child,
    super.key,
    this.trail,
  });

  static InheritedTrail of(BuildContext context) {
    final InheritedTrail? result =
        context.dependOnInheritedWidgetOfExactType<InheritedTrail>();
    assert(result != null, 'No Trail found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedTrail oldWidget) {
    return oldWidget.trail != trail;
  }
}
