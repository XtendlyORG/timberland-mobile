// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'widgets.dart';

class TimberlandAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? backButton;
  final List<Widget>? actions;
  final bool showEndDrawerButton;
  const TimberlandAppbar({
    Key? key,
    this.backButton,
    this.actions,
    this.showEndDrawerButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.primary,
      leading: backButton,
      automaticallyImplyLeading: backButton != null,
      actions: showEndDrawerButton
          ? [
              if (actions != null) ...actions!,
              const Tooltip(
                message: 'Dashboard',
                child: DrawerIconButton(),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
