import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/router.dart';
import '../../../features/authentication/domain/entities/user.dart';

class ProfileSettingsButton extends StatelessWidget {
  const ProfileSettingsButton({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tooltip: 'Update Profile',
      icon: Container(
        height: 24,
        width: 24,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.settings,
          color: Theme.of(context).backgroundColor,
          size: 18,
        ),
      ),
      itemBuilder: (ctx) => [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: ListTile(
            title: const Text('Update Password'),
            onTap: () {
              // TODO: implement update password page
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: ListTile(
            title: const Text('Update Email'),
            onTap: () {
              context.pushNamed(
                Routes.updateEmail.name,
              );
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: ListTile(
            title: const Text('Update Information'),
            onTap: () {
              context.pushNamed(
                Routes.updateProfile.name,
                extra: user,
              );
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
