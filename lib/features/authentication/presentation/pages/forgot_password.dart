import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_container.dart';
import 'package:timberland_biketrail/core/utils/email_validator.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.transparent,
        leading: Tooltip(
          message: 'Back',
          child: IconButton(
            onPressed: () {
              context.pop();
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
              padding: const EdgeInsets.symmetric(vertical: kToolbarHeight),
              child: AutoSizeText(
                'Forgot Password',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const Text("Enter your email and get help logging in."),
            const SizedBox(
              height: kVerticalPadding * 2,
            ),
            const ForgotPasswordForm(),
          ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailCtrl,
              validator: validateEmail,
              decoration: const InputDecoration(
                hintText: 'Email Address',
              ),
            ),
            const SizedBox(
              height: kVerticalPadding,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
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
