import 'package:flutter/material.dart';

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
            TextButton(
              onPressed: () {},
              child: const Text('Trail Directory'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('My Profile'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Booking'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('QR Generator'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Rules'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Contact Us'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Emergency'),
            ),
          ],
        ),
      ),
    );
  }
}
