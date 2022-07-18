// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';

import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  // final bool signInWithFingerprint;
  const LoginPage({
    Key? key,
    // this.signInWithFingerprint = false,
  }) : super(key: key);

  void authtenticateWithFingerPrint() async {
    final LocalAuthentication auth = LocalAuthentication();

    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate & canAuthenticateWithBiometrics) {
      try {
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: "Authenticate with your fingerprint to continue.",
          options: const AuthenticationOptions(
            biometricOnly: true,
          ),
        );
        if (didAuthenticate) {
          Session().fingerprintAuthenticated();
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool signInWithFingerprint = Session().currentUID != null;
    log(signInWithFingerprint.toString());
    if (signInWithFingerprint) {
      authtenticateWithFingerPrint();
    }
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: AuthPageContainer(
            child: Column(
              children: [
                const LoginForm(),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                Text.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.titleSmall,
                    children: [
                      const TextSpan(
                        text: "Don't have an account yet? ",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: "Register",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            log('register');
                            context.pushNamed(Routes.register.name);
                          },
                      ),
                    ],
                  ),
                ),
                if (signInWithFingerprint) ...[
                  const SizedBox(
                    height: kVerticalPadding,
                  ),
                  IconButton(
                    onPressed: authtenticateWithFingerPrint,
                    icon: const Icon(
                      Icons.fingerprint_rounded,
                      size: 32,
                    ),
                  ),
                ],
                const SizedBox(
                  height: kVerticalPadding,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Contact Us',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
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
