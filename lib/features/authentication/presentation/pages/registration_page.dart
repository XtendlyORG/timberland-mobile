import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/auth_page_container.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: AuthPageContainer(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
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
          ),
        ),
      ),
    );
  }
}
