// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_logo.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

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
    final screen = MediaQuery.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
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
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const RepaintBoundary(
                    child: CircularProgressIndicator(),
                  ),
                  AutoSizeText(
                    state.loadingMessage,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        }
        if (state is OtpSent) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AutoSizeText(
                "OTP is sent to ${state.registerParameter.email}",
                maxLines: 1,
              ),
            ),
          );
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
            alignment: alignment,
            child: SingleChildScrollView(
              child: SizedBox(
                height: (screen.orientation == Orientation.portrait
                        ? screen.size.height
                        : screen.size.width) -
                    kToolbarHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding,
                    vertical: kVerticalPadding,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: TimberlandLogo(),
                      ),
                      const Spacer(),
                      child,
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
