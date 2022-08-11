// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/params.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/otp_validation_form.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/filled_text_button.dart';
import '../../../../core/router/router.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_page_container.dart';
import '../widgets/otp_resend_button.dart';

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
          extra: (authBloc.state as OtpSent).registerParameter,
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
                  RegisterParameter? registerParameter;
                  if (authBloc.state is OtpSent) {
                    registerParameter =
                        (authBloc.state as OtpSent).registerParameter;
                  } else if (authBloc.state is AuthError) {
                    registerParameter =
                        (authBloc.state as AuthError).registerParameter!;
                  }
                  context.goNamed(
                    routeNameOnPop,
                    extra: registerParameter,
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
          body: AuthPageContainer(
            alignment: Alignment.center,
            child: OtpVerificationForm(
              onResend: () {
                RegisterParameter? registerParameter;
                if (authBloc.state is OtpSent) {
                  registerParameter =
                      (authBloc.state as OtpSent).registerParameter;
                } else if (authBloc.state is AuthError) {
                  registerParameter =
                      (authBloc.state as AuthError).registerParameter!;
                }
                if (routeNameOnPop == Routes.login.name) {
                  authBloc.add(
                    LoginEvent(
                      loginParameter: LoginParameter(
                        email: registerParameter!.email,
                        password: registerParameter.password,
                      ),
                    ),
                  );
                } else {
                  authBloc.add(
                    SendOtpEvent(
                      registerParameter: registerParameter!,
                    ),
                  );
                }
              },
              onSubmit: (otp) {
                RegisterParameter? registerParameter;
                if (authBloc.state is OtpSent) {
                  registerParameter =
                      (authBloc.state as OtpSent).registerParameter;
                } else if (authBloc.state is AuthError) {
                  registerParameter =
                      (authBloc.state as AuthError).registerParameter!;
                }
                authBloc.add(
                  RegisterEvent(
                    registerParameter: registerParameter!.copyWith(otp: otp),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
