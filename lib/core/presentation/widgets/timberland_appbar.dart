// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'widgets.dart';

class TimberlandAppbar extends StatelessWidget {
  final Widget? backButton;
  final List<Widget>? actions;
  const TimberlandAppbar({
    Key? key,
    this.backButton,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.primary,
      leading: backButton,
      actions: [
        if (actions != null) ...actions!,
        const DrawerIconButton(),
      ],
    );
  }
}
