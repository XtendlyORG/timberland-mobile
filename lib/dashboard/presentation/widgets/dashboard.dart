// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/features/emergency/presentation/widgets/emergency_dialog.dart';

import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

import '../../../core/router/router.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const DashBoardHeader(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    DashBoardListTile(
                      onTap: () {
                        context.goNamed(Routes.profile.name);
                        Navigator.pop(context);
                      },
                      leading: const Image(
                        image: AssetImage('assets/icons/profile-icon.png'),
                        height: 24,
                        width: 24,
                      ),
                      titleText: 'My Profile',
                    ),
                    DashBoardListTile(
                      onTap: () {
                        context.goNamed(Routes.trails.name);
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.map_outlined),
                      titleText: 'Trail Directory',
                    ),
                    DashBoardListTile(
                      onTap: () {
                        context.pushNamed(Routes.booking.name);
                        Navigator.pop(context);
                      },
                      leading: const Image(
                        image: AssetImage('assets/icons/booking-icon.png'),
                        height: 24,
                        width: 24,
                      ),
                      titleText: 'Booking',
                    ),
                    DashBoardListTile(
                      onTap: () {
                        context.pushNamed(Routes.contacts.name);
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.phone_outlined),
                      titleText: 'Contact Us',
                    ),
                    DashBoardListTile(
                      onTap: () {
                        context.goNamed(Routes.rules.name);
                        Navigator.pop(context);
                      },
                      leading: const Image(
                        image: AssetImage('assets/icons/rules-icon.png'),
                        height: 24,
                        width: 24,
                      ),
                      titleText: 'Rules',
                    ),
                    DashBoardListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return const EmergencyDialog();
                          },
                        );
                      },
                      leading: const Image(
                        image: AssetImage('assets/icons/emergency-icon.png'),
                        color: TimberlandColor.secondaryColor,
                        height: 24,
                        width: 24,
                      ),
                      titleText: 'Emergency',
                      titleTextColor: TimberlandColor.secondaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    DashBoardListTile(
                      onTap: () {
                        context.pushNamed(Routes.faqs.name);
                        Navigator.pop(context);
                      },
                      leading: const Image(
                        image: AssetImage('assets/icons/faqs-icon.png'),
                        height: 24,
                        width: 24,
                      ),
                      titleText: 'FAQs',
                    ),
                    DashBoardListTile(
                      onTap: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(const LogoutEvent());
                      },
                      leading: const Icon(Icons.logout),
                      titleText: 'Logout',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DashBoardListTile extends StatelessWidget {
  final VoidCallback onTap;
  final Widget? leading;
  final String titleText;
  final Color titleTextColor;
  const DashBoardListTile({
    Key? key,
    required this.onTap,
    this.leading,
    required this.titleText,
    this.titleTextColor = TimberlandColor.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minLeadingWidth: 20,
      leading: leading,
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: titleTextColor,
            ),
      ),
    );
  }
}
