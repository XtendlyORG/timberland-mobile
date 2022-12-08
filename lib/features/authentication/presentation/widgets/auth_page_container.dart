import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';
import 'package:timberland_biketrail/core/presentation/widgets/lock_user_widget.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';

class AuthPageContainer extends StatelessWidget {
  final Widget child;
  final Alignment alignment;
  final ScrollBehavior? scrollBehavior;
  const AuthPageContainer({
    Key? key,
    required this.child,
    this.alignment = Alignment.center,
    this.scrollBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLocked) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                backgroundColor: TimberlandColor.background,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LockUserWidget(
                  title: 'Too many login attempts.',
                  onFinishTimer: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      const UnlockAuthEvent(),
                    );
                  },
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
          showSuccess(state.message);
          BlocProvider.of<NotificationsBloc>(context)
              .add(CheckForFCMTokenUpdate());
          context.goNamed(Routes.home.name);
        }
        if (state is AuthLoading) {
          showLoading(state.loadingMessage);
        }
        if (state is OtpSent && state.hasError == null) {
          showInfo(state.message);
        }
        if (state is AuthError) {
          showError(state.errorMessage);
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
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: kToolbarHeight / 2),
                            child: TimberlandLogo(),
                          ),
                        ),
                        const SizedBox(height: kVerticalPadding),
                        Flexible(
                          fit: FlexFit.loose,
                          child: ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: TimberlandColor.linearGradient,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: kHorizontalPadding,
                                    // vertical: kVerticalPadding,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: kVerticalPadding * 2,
                                          bottom: kVerticalPadding,
                                        ),
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              maxWidth: kMaxWidthMobile),
                                          child: child,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),

          // Align(
          //   alignment: Alignment.topCenter,
          //   child: ScrollConfiguration(
          //     behavior: scrollBehavior ?? const ScrollBehavior(),
          //     child: ListView(
          //       shrinkWrap: true,
          //       padding: EdgeInsets.zero,
          //       children: [
          //         const Align(
          //           alignment: Alignment.topCenter,
          //           child: Padding(
          //             padding: EdgeInsets.only(top: kToolbarHeight / 2),
          //             child: TimberlandLogo(),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.symmetric(
          //             horizontal: kHorizontalPadding,
          //             // vertical: kVerticalPadding,
          //           ),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.only(
          //                   top: kVerticalPadding * 2,
          //                   bottom: kVerticalPadding,
          //                 ),
          //                 child: ConstrainedBox(
          //                   constraints:
          //                       const BoxConstraints(maxWidth: kMaxWidthMobile),
          //                   child: child,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}


//  SizedOverflowBox(
//   size: const Size(0,0),
//   child: ClipRRect(
//     clipBehavior: Clip.hardEdge,
//     borderRadius: const BorderRadius.vertical(
//       top: Radius.circular(20),
//     ),
//     child: BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           gradient: TimberlandColor.linearGradient,
//         ),
//         child: SizedBox(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.longestSide,
//         ),
//       ),
//     ),
//   ),
// ),