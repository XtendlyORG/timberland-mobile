import 'package:flutter/material.dart';

import 'circular_icon_button.dart';

class DrawerIconButton extends StatelessWidget {
  const DrawerIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularIconButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      size: 24,
      onTap: () {
        Scaffold.of(context).openEndDrawer();
      },
    );
  }
}
