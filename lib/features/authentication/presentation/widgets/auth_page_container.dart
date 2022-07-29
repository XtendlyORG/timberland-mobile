// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_logo.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/auth_locked_widget.dart';

class AuthPageContainer extends StatelessWidget {
  final Widget child;
  final Alignment alignment;
  const AuthPageContainer({
    Key? key,
    required this.child,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLocked) {
          log('AuthState: $state');
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                child: AuthLockedWidget(
                  duration:
                      state.lockUntil.difference(DateTime.now()).inSeconds,
                ),
              );
            },
          );
        }
        if (state is UnAuthenticated) {
          if (state.keepCurrentUser) {
            Navigator.pop(context);
          }
        }
        if (state is Authenticated) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: AutoSizeText(
                  state.message,
                  maxLines: 1,
                ),
              ),
            );
          context.goNamed(Routes.home.name);
        }
        if (state is AuthLoading) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const SizedBox(
                      height: 24,
                      width: 24,
                      child: RepaintBoundary(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(width: kVerticalPadding),
                    Expanded(
                      child: AutoSizeText(
                        state.loadingMessage,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: AutoSizeText(
                  state.errorMessage,
                  maxLines: 1,
                ),
              ),
            );
        }
        if (state is OtpSent) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: AutoSizeText(
                  state.message,
                  maxLines: 1,
                ),
              ),
            );
        }
        if (state is UserGuideFinished) {
          context.goNamed(Routes.booking.name);
        }
      },
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: Image(
              image: AssetImage('assets/images/top-right-frame.png'),
              width: 130,
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Image(
              image: AssetImage('assets/images/bottom-left-frame.png'),
              width: 150,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: kToolbarHeight / 2),
                    child: TimberlandLogo(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding,
                    // vertical: kVerticalPadding,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: kVerticalPadding * 2,
                          bottom: kVerticalPadding,
                        ),
                        child: child,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
