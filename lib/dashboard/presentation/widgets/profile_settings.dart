import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/padding.dart';
import '../../../core/presentation/widgets/dialogs/custom_dialog.dart';
import '../../../core/presentation/widgets/state_indicators/state_indicators.dart';
import '../../../core/router/router.dart';
import '../../../core/themes/timberland_color.dart';
import '../../../features/authentication/domain/entities/user.dart';
import '../../../features/authentication/presentation/bloc/auth_bloc.dart';

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
          color: Theme.of(context).colorScheme.background,
          size: 18,
        ),
      ),
      itemBuilder: (ctx) => [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: ListTile(
            title: const Text('Update Password'),
            onTap: () {
              context.pushNamed(
                Routes.updatePassword.name,
              );
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
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: ListTile(
            title: const Text('Delete Account'),
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (ctx) {
                    return CustomDialog(
                      content: Container(
                        decoration: BoxDecoration(
                          gradient: TimberlandColor.linearGradient,
                        ),
                        padding: const EdgeInsets.only(
                          top: kVerticalPadding,
                          left: kVerticalPadding,
                          right: kVerticalPadding,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kVerticalPadding,
                                ),
                                child: AutoSizeText(
                                  'Delete Account',
                                  maxLines: 1,
                                  minFontSize: 16,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                            const SizedBox(height: kVerticalPadding * 1.5),
                            AutoSizeText(
                              'Are you sure you want to delete your account?',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              minFontSize: 12,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: kVerticalPadding),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                const SizedBox(width: kVerticalPadding / 2),
                                TextButton(
                                  onPressed: () {
                                    showLoading('Deleting Account');
                                    BlocProvider.of<AuthBloc>(context).add(const DeleteAccountEvent());

                                    Navigator.pop(ctx);
                                  },
                                  child: const Text('Yes'),
                                )
                              ],
                            ),
                            const SizedBox(height: kVerticalPadding / 2)
                          ],
                        ),
                      ),
                    );
                  });
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
