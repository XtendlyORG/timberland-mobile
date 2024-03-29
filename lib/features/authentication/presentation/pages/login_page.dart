// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/error_codes.dart';
import 'package:local_auth/local_auth.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_scroll_behavior.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/dialogs/permanently_locked_dialog.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  // final bool signInWithFingerprint;
  const LoginPage({
    Key? key,
    // this.signInWithFingerprint = false,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool displayFingerPrintDialog;
  late final bool signInWithFingerprint;
  @override
  void initState() {
    super.initState();
    signInWithFingerprint = Session().currentUser != null;
    displayFingerPrintDialog = signInWithFingerprint;
  }

  void authtenticateWithFingerPrint({
    required BuildContext context,
    required VoidCallback onLockedOut,
  }) async {
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
            stickyAuth: true,
          ),
        );
        if (didAuthenticate) {
          Session().fingerprintAuthenticated();
        }
      } on PlatformException catch (e) {
        log(e.code);
        if (e.code == lockedOut) {
          onLockedOut();
        }
        if (e.code == permanentlyLockedOut) {
          showDialog(
            context: context,
            builder: (ctx) {
              return const PermanentlyLockedDialog();
            },
          );
        }
      } catch (e) {
        log(e.toString());
      }
    }
    if (mounted) {
      setState(() {
        displayFingerPrintDialog = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Session().lockAuthUntil == null) {
      if (displayFingerPrintDialog) {
        authtenticateWithFingerPrint(
          context: context,
          onLockedOut: () {
            BlocProvider.of<AuthBloc>(context).add(
              const LockAuthEvent(),
            );
          },
        );
      }
    } else {
      BlocProvider.of<AuthBloc>(context).add(
        const LockAuthEvent(),
      );
    }

    return DecoratedSafeArea(
      child: Scaffold(
        body: AuthPageContainer(
          scrollBehavior: const CustomScrollBehavior(),
          child: Column(
            children: [
              const SizedBox(
                height: kHorizontalPadding,
              ),
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
                textAlign: TextAlign.center,
              ),
              if (signInWithFingerprint) ...[
                const SizedBox(
                  height: kVerticalPadding,
                ),
                IconButton(
                  onPressed: () {
                    if (Session().lockAuthUntil == null) {
                      authtenticateWithFingerPrint(
                        context: context,
                        onLockedOut: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            const LockAuthEvent(),
                          );
                        },
                      );
                    } else {
                      BlocProvider.of<AuthBloc>(context).add(
                        const LockAuthEvent(),
                      );
                    }
                  },
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
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.pushNamed(Routes.contacts.name);
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
