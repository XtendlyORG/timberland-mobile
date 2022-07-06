import 'package:flutter/material.dart';

class DrawerIconButton extends StatelessWidget {
  const DrawerIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
      },
      icon: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      ),
    );
  }
}
