import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';

import 'circular_icon_button.dart';

class DrawerIconButton extends StatelessWidget {
  const DrawerIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kVerticalPadding),
      child: CircularIconButton(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        size: 24,
        onTap: () {
          Scaffold.of(context).openEndDrawer();
        },
      ),
    );
  }
}
