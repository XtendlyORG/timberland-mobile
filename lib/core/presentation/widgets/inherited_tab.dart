// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class InheritedTabIndex extends InheritedWidget {
  final int tabIndex;
  const InheritedTabIndex({
    super.key,
    required this.tabIndex,
    required super.child,
  });

  static InheritedTabIndex of(BuildContext context) {
    final InheritedTabIndex? result =
        context.dependOnInheritedWidgetOfExactType<InheritedTabIndex>();
    assert(result != null, 'No InheritedTab found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedTabIndex oldWidget) =>
      oldWidget.tabIndex != tabIndex;
}
