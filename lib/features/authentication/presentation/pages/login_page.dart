import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/routes/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
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
              'Login Page',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            TextButton(
              onPressed: () {
                context.goNamed(Routes.register.name);
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
