import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/dialogs/custom_dialog.dart';

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
    );
  }

  void handleBackButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return CustomDialog(
          content: Padding(
            padding: const EdgeInsets.only(
              top: kVerticalPadding,
              left: kVerticalPadding,
              right: kVerticalPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding,
                    vertical: kVerticalPadding,
                  ),
                  child: Text(
                    "Discard password updates?",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: VerticalDivider(
                          thickness: 1.5,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(ctx, true);
                            BlocProvider.of<ProfileBloc>(context)
                                .add(const CancelUpdateRequest());
                          },
                          child: const Text('Discard'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
