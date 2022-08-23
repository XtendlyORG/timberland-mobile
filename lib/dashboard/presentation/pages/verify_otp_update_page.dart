import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/presentation/widgets/lock_user_widget.dart';
import '../../../core/presentation/widgets/snackbar_content/show_snackbar.dart';
import '../../../core/presentation/widgets/timberland_scaffold.dart';
import '../../../core/router/router.dart';
import '../../../core/themes/timberland_color.dart';
import '../../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../../../features/authentication/presentation/widgets/otp_validation_form.dart';
import '../bloc/profile_bloc.dart';

class VerifyUpdateOtpPage extends StatelessWidget {
  const VerifyUpdateOtpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is OTPToUpdateSent) {
          showSnackBar(SnackBar(
            content: AutoSizeText('New OTP is sent to ${state.email}'),
          ));
        }
        if (state is ProfileOtpError) {
          if (state.otpPenaltyDuration != 0) {
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
                    duration: state.otpPenaltyDuration!,
                  ),
                );
              },
            );
          }

          showSnackBar(
            SnackBar(
              content: AutoSizeText(
                state.errorMessage,
              ),
            ),
          );
        }
        if (state is ProfileUpdated) {
          showSnackBar(
            SnackBar(
              content: const AutoSizeText('Profile Updated'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: kHorizontalPadding,
              ),
            ),
          );

          BlocProvider.of<AuthBloc>(context).add(
            UpdateUser(newUser: state.user),
          );

          context.goNamed(Routes.profile.name);
        }
      },
      child: TimberlandScaffold(
        showNavbar: false,
        body: Padding(
          padding: const EdgeInsets.only(
            left: kHorizontalPadding,
            right: kHorizontalPadding,
            bottom: kHorizontalPadding,
          ),
          child: OtpVerificationForm(
            onResend: () {
              var email;
              final bloc = BlocProvider.of<ProfileBloc>(context);
              if (bloc.state is OTPToUpdateSent) {
                email = (bloc.state as OTPToUpdateSent).email;
              } else {
                email = (bloc.state as ProfileOtpError).email;
              }
              BlocProvider.of<ProfileBloc>(context).add(
                ResendEmailOTP(email: email),
              );
            },
            onSubmit: ((otp) {
              var email;
              final bloc = BlocProvider.of<ProfileBloc>(context);
              if (bloc.state is OTPToUpdateSent) {
                email = (bloc.state as OTPToUpdateSent).email;
              } else {
                email = (bloc.state as ProfileOtpError).email;
              }

              bloc.add(
                VerifyEmailUpdate(
                  email: email,
                  otp: otp,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
