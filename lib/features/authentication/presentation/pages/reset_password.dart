import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/form_fields/form_fields.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_container.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/forgot_password.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.goNamed(Routes.forgotPassword.name);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.transparent,
            leading: Tooltip(
              message: 'Back',
              child: IconButton(
                onPressed: () {
                  context.goNamed(Routes.forgotPassword.name);
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: TimberlandContainer(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: kToolbarHeight, bottom: kHorizontalPadding),
                  child: AutoSizeText(
                    'Create new password',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Text(
                  "Please enter your password.",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: kVerticalPadding * 2,
                ),
                const ResetPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final passwordCtrl = TextEditingController();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is PasswordUpdated) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: AutoSizeText(
                  'Password Updated',
                  maxLines: 1,
                ),
              ),
            );
          context.goNamed(Routes.login.name);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              PasswordField(
                controller: passwordCtrl,
                hintText: 'New Password',
              ),
              const SizedBox(
                height: kVerticalPadding,
              ),
              PasswordField(
                hintText: 'Confirm Password',
                controller: TextEditingController(),
                validator: (val) {
                  if (val != passwordCtrl.text) {
                    return "Password doesn't match.";
                  }
                  return null;
                },
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
                        ResetPasswordEvent(
                          resetPasswordParameter: ResetPasswordParameter(
                            email: (BlocProvider.of<AuthBloc>(context).state
                                    as SettingNewPassword)
                                .email,
                            password: passwordCtrl.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text("Confirm"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
