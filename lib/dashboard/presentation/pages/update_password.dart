import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/presentation/widgets/filled_text_button.dart';
import '../../../core/presentation/widgets/form_fields/form_fields.dart';
import '../../../core/presentation/widgets/snackbar_content/loading_snackbar_content.dart';
import '../../../core/presentation/widgets/snackbar_content/show_snackbar.dart';
import '../../../core/presentation/widgets/timberland_scaffold.dart';
import '../../../core/router/router.dart';
import '../bloc/profile_bloc.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is UpdatingProfile) {
          showSnackBar(
            const SnackBar(
              content:
                  LoadingSnackBarContent(loadingMessage: 'Updating Profile'),
            ),
          );
        }
        if (state is ProfileUpdateError) {
          showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));
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
          context.goNamed(Routes.profile.name);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          handleBackButton(context);
          return false;
        },
        child: TimberlandScaffold(
          titleText: 'Update Password',
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
            child: _UpdatePasswordForm(),
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

class _UpdatePasswordForm extends StatelessWidget {
  const _UpdatePasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController oldPasswordCtrl = TextEditingController();
    final TextEditingController newPasswordCtrl = TextEditingController();
    return Form(
      key: formKey,
      child: Column(
        children: [
          PasswordField(
            controller: oldPasswordCtrl,
            hintText: 'Current Password',
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          PasswordField(
            controller: newPasswordCtrl,
            hintText: 'New Password',
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          SizedBox(
            width: double.infinity,
            child: FilledTextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<ProfileBloc>(context).add(
                    UpdatePasswordRequest(
                      oldPassword: oldPasswordCtrl.text,
                      newPassword: newPasswordCtrl.text,
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
