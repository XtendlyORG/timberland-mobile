import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/filled_text_button.dart';
import '../../../../core/presentation/widgets/form_fields/email_field.dart';
import '../../../../core/router/router.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_page_container.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.goNamed(Routes.login.name);
        return false;
      },
      child: DecoratedSafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.transparent,
            leading: Tooltip(
              message: 'Back',
              child: IconButton(
                onPressed: () {
                  context.goNamed(Routes.login.name);
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
                Text(
                  'Forgot Password',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: kVerticalPadding * 2,
                      horizontal: kVerticalPadding),
                  child: Text(
                    "Enter your email and get help logging in.",
                    textAlign: TextAlign.center,
                  ),
                ),
                const ForgotPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailCtrl = TextEditingController();
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        if (current is SettingNewPassword) {
          context.pushNamed(Routes.resetPassword.name);
          showSuccess('OTP Verified');
        }
        return current is OtpSent;
      },
      listener: (context, state) {
        if ((state as OtpSent).hasError == null && state is! OtpResent) {
          context.pushNamed(Routes.forgotPasswordVerify.name);
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            EmailField(
              controller: emailCtrl,
            ),
            const SizedBox(
              height: kVerticalPadding,
            ),
            SizedBox(
              width: double.infinity,
              child: FilledTextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<AuthBloc>(context).add(
                      ForgotPasswordEvent(
                        email: emailCtrl.text,
                      ),
                    );
                  }
                },
                child: const Text("Send Email"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
