// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/lock_user_widget.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/params.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/otp_validation_form.dart';

import '../../../../core/router/router.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_page_container.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({
    Key? key,
    required this.routeNameOnPop,
  }) : super(key: key);
  final String routeNameOnPop;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return WillPopScope(
      onWillPop: () async {
        context.goNamed(
          routeNameOnPop,
          extra: (authBloc.state as OtpSent).parameter,
        );
        return false;
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
                  var parameter;
                  if (authBloc.state is OtpSent) {
                    parameter = (authBloc.state as OtpSent).parameter;
                  } else if (authBloc.state is AuthError) {
                    parameter = (authBloc.state as AuthError).parameter!;
                  }
                  context.goNamed(
                    routeNameOnPop,
                    extra: parameter,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) => current is AuthError,
            listener: (context, state) {
              if (state is AuthError) {
                if (state.penaltyDuration != 0) {
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
                          onFinishTimer: () {
                            Navigator.pop(context);
                          },
                          duration: state.penaltyDuration!,
                        ),
                      );
                    },
                  );
                }
              }
            },
            child: AuthPageContainer(
              alignment: Alignment.center,
              child: OtpVerificationForm(
                onResend: () {
                  var parameter;
                  if (authBloc.state is OtpSent) {
                    parameter = (authBloc.state as OtpSent).parameter;
                  } else if (authBloc.state is AuthError) {
                    parameter = (authBloc.state as AuthError).parameter!;
                  }
                  authBloc.add(ResendOTPEvent(parameter: parameter));
                },
                onSubmit: (otp) {
                  var parameter;
                  if (authBloc.state is OtpSent) {
                    parameter = (authBloc.state as OtpSent).parameter;
                  } else if (authBloc.state is AuthError) {
                    parameter = (authBloc.state as AuthError).parameter;
                  }
                  if (routeNameOnPop == Routes.forgotPassword.name) {
                    authBloc.add(
                      VerifyForgotPasswordEvent(
                        parameter: parameter,
                        otp: otp,
                      ),
                    );
                  } else {
                    authBloc.add(
                      VerifyRegisterEvent(
                        parameter: parameter is RegisterParameter
                            ? parameter
                            : RegisterParameter(
                                firstName: '',
                                lastName: '',
                                email: parameter.email,
                                mobileNumber: '',
                                password: '',
                              ),
                        otp: otp,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
