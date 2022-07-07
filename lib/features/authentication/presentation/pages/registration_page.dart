// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/router/router.dart';

import 'package:timberland_biketrail/features/authentication/presentation/widgets/widgets.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0,
          ),
          extendBodyBehindAppBar: true,
          body: AuthPageContainer(
            child: Column(
              children: [
                const RegistrationForm(),
                const SizedBox(
                  height: kFieldPadding,
                ),
                Text.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.titleSmall,
                    children: [
                      const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: "Log in",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            log('login');
                            context.goNamed(Routes.login.name);
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
