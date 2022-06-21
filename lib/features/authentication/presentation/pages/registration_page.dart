import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/routes/routes.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registration Page',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            TextButton(
              onPressed: () {
                context.goNamed(Routes.login.name);
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
