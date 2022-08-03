// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/params.dart';

class InheritedRegisterParameter extends InheritedWidget {
  final RegisterParameter? registerParameter;
  const InheritedRegisterParameter({
    required super.child,
    super.key,
    this.registerParameter,
  });

  static InheritedRegisterParameter of(BuildContext context) {
    final InheritedRegisterParameter? result = context
        .dependOnInheritedWidgetOfExactType<InheritedRegisterParameter>();
    assert(result != null, 'No RegisterParameter found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedRegisterParameter oldWidget) {
    return oldWidget.registerParameter != registerParameter;
  }
}
