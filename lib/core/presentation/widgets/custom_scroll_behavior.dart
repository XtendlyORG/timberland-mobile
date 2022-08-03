import 'package:flutter/cupertino.dart';

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
