// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/params.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/widgets.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if (Navigator.canPop(context)) {
        //   Navigator.pop(context);
        // } else {
        //   context.goNamed(Routes.login.name);
        // }
        // return false;
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0,
            leading: Tooltip(
              message: 'Back',
              child: IconButton(
                onPressed: () {
                  // if (Navigator.canPop(context)) {
                  //   Navigator.pop(context);
                  // } else {
                  //   context.goNamed(Routes.login.name);
                  // }
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: AuthPageContainer(
            child: Column(
              children: [
                RegistrationForm(
                  onSumbit: (
                    String firstName,
                    String? middleName,
                    String lastName,
                    String email,
                    String password,
                    String mobileNumber,
                  ) {
                    context.pushNamed(
                      Routes.registerContinuation.name,
                      extra: RegisterParameter(
                        firstName: firstName,
                        middleName: middleName,
                        lastName: lastName,
                        email: email,
                        password: password,
                        mobileNumber: mobileNumber,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: kVerticalPadding,
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
                            // context.goNamed(Routes.login.name);
                            Navigator.pop(context);
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
