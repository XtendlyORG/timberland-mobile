import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/router/router.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                context.goNamed(Routes.trails.name);
                Navigator.pop(context);
              },
              title: const Text('Trail Directory'),
            ),
            ListTile(
              onTap: () {
                context.goNamed(Routes.profile.name);
                Navigator.pop(context);
              },
              title: const Text('My Profile'),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Booking'),
            ),
            ListTile(
              onTap: () {},
              title: const Text('QR Generator'),
            ),
            ListTile(
              onTap: () {
                context.goNamed(Routes.rules.name);
                Navigator.pop(context);
              },
              title: const Text('Rules'),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Contact Us'),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Emergency'),
            ),
          ],
        ),
      ),
    );
  }
}
