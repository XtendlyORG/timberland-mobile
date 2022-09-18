import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/presentation/widgets/filled_text_button.dart';
import '../../../core/presentation/widgets/form_fields/form_fields.dart';
import '../../../core/presentation/widgets/state_indicators/state_indicators.dart';
import '../../../core/presentation/widgets/timberland_scaffold.dart';
import '../../../core/router/router.dart';
import '../bloc/profile_bloc.dart';

class UpdateEmailPage extends StatelessWidget {
  const UpdateEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is OTPToUpdateSent) {
          showInfo('OTP is sent to ${state.email}');
          context.pushNamed(Routes.verifyUpdateOtp.name);
        }
        if (state is ProfileUpdateError) {
          showError(state.errorMessage);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          handleBackButton(context);
          return false;
        },
        child: TimberlandScaffold(
          titleText: 'Update Email',
          showNavbar: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                handleBackButton(context);
              },
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(kHorizontalPadding),
            child: _UpdateEmailForm(),
          ),
        ),
      ),
    );
  }

  void handleBackButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: const SizedBox(
            child: Text("Discard profile updates?"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx, true);
                BlocProvider.of<ProfileBloc>(context)
                    .add(const CancelUpdateRequest());
              },
              child: const Text('Discard'),
            ),
          ],
        );
      },
    ).then(
      (value) {
        if (value) {
          Navigator.pop(context);
        }
      },
    );
  }
}

class _UpdateEmailForm extends StatelessWidget {
  const _UpdateEmailForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController passwordCtrl = TextEditingController();
    return Form(
      key: formKey,
      child: Column(
        children: [
          EmailField(
            hintText: 'New Email Address',
            controller: emailCtrl,
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          PasswordField(
            controller: passwordCtrl,
            hintText: 'Current Password',
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          SizedBox(
            width: double.infinity,
            child: FilledTextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  showLoading('Updating email');
                  BlocProvider.of<ProfileBloc>(context).add(
                    UpdateEmailRequest(
                      email: emailCtrl.text,
                      password: passwordCtrl.text,
                    ),
                  );
                }
              },
              child: const Text("Confirm"),
            ),
          ),
        ],
      ),
    );
  }
}
