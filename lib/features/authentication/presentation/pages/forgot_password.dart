import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
                AutoSizeText(
                  'Forgot Password',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: kVerticalPadding * 2,horizontal: kVerticalPadding),
                  child: Text("Enter your email and get help logging in.",textAlign: TextAlign.center,),
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
      listener: (context, state) {
        if (state is OtpSent) {
          context.goNamed(
            Routes.otpVerification.name,
            extra: Routes.forgotPassword.name,
          );
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
