// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

class InheritedUser extends InheritedWidget {
  final User user;
  const InheritedUser({
    super.key,
    required this.user,
    required super.child,
  });

  static InheritedUser of(BuildContext context) {
    final InheritedUser? result =
        context.dependOnInheritedWidgetOfExactType<InheritedUser>();
    assert(result != null, 'No InheritedUser found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedUser oldWidget) =>
      oldWidget.user != user;
}
