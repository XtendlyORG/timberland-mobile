import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/dashboard_header.dart';

import '../../../core/router/router.dart';
import '../../../core/utils/session.dart';

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
                    ListTile(
                      onTap: () {
                        context.goNamed(Routes.trails.name);
                        Navigator.pop(context);
                      },
                      minLeadingWidth: 20,
                      leading: const Icon(Icons.map_outlined),
                      title: const Text('Trail Directory'),
                    ),
                    ListTile(
                      onTap: () {
                        context.goNamed(Routes.profile.name);
                        Navigator.pop(context);
                      },
                      minLeadingWidth: 20,
                      leading: const Image(
                        image: AssetImage('assets/icons/profile-icon.png'),
                        height: 24,
                        width: 24,
                      ),
                      title: const Text('My Profile'),
                    ),
                    ListTile(
                      onTap: () {},
                      minLeadingWidth: 20,
                      leading: const Image(
                        image: AssetImage('assets/icons/booking-icon.png'),
                        height: 24,
                        width: 24,
                      ),
                      title: const Text('Booking'),
                    ),
                    ListTile(
                      onTap: () {
                        context.pushNamed(Routes.qr.name);
                        Navigator.pop(context);
                      },
                      minLeadingWidth: 20,
                      leading: const Icon(Icons.qr_code),
                      title: const Text('QR Generator'),
                    ),
                    ListTile(
                      onTap: () {
                        context.goNamed(Routes.rules.name);
                        Navigator.pop(context);
                      },
                      minLeadingWidth: 20,
                      leading: const Image(
                        image: AssetImage('assets/icons/rules-icon.png'),
                        height: 24,
                        width: 24,
                      ),
                      title: const Text('Rules'),
                    ),
                    ListTile(
                      onTap: () {},
                      minLeadingWidth: 20,
                      leading: const Icon(Icons.phone_outlined),
                      title: const Text('Contact Us'),
                    ),
                    ListTile(
                      onTap: () {},
                      minLeadingWidth: 20,
                      leading: const Image(
                        image: AssetImage('assets/icons/emergency-icon.png'),
                        height: 24,
                        width: 24,
                      ),
                      title: const Text('Emergency'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Session().logout();
                      },
                      minLeadingWidth: 20,
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
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