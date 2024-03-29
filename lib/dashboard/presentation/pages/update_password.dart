import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/discard_update_dialog.dart';

import '../../../core/constants/constants.dart';
import '../../../core/presentation/widgets/filled_text_button.dart';
import '../../../core/presentation/widgets/form_fields/form_fields.dart';
import '../../../core/presentation/widgets/state_indicators/state_indicators.dart';
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
          showLoading('Updating Profile');
        }
        if (state is ProfileUpdateError) {
          showError(state.errorMessage);
        }
        if (state is ProfileUpdated) {
          showSuccess(state.message);
          context.goNamed(Routes.profile.name);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          handleBackButton(context);
          return false;
        },
        child: DecoratedSafeArea(
          child: TimberlandScaffold(
            titleText: 'Update Password',
            extendBodyBehindAppbar: true,
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
      ),
    );
  }

  void handleBackButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return const DiscardUpdatesDialog(
          promptMessage: 'Discard password updates?',
        );
      },
    ).then(
      (value) {
        if (value is bool && value) {
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
