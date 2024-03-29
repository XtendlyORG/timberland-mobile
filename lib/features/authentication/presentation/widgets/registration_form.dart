// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/form_fields/form_fields.dart';
import 'package:timberland_biketrail/core/utils/validators/non_empty_validator.dart';
import 'package:timberland_biketrail/dashboard/domain/params/update_user_detail.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({
    Key? key,
    this.user,
    required this.onSumbit,
  }) : super(key: key);

  final void Function(
    String firstName,
    String? middleName,
    String lastName,
    String email,
    String password,
    String mobileNumber,
  ) onSumbit;
  final UpdateUserDetailsParams? user;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final firstNameCtrl = TextEditingController();
    final middleNameCtrl = TextEditingController();
    final lastNameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final mobileNumberCtrl = TextEditingController();

    if (user != null) {
      firstNameCtrl.text = user!.firstName;
      lastNameCtrl.text = user!.lastName;
      middleNameCtrl.text = user!.middleName ?? '';
      mobileNumberCtrl.text = user!.mobileNumber;
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: kVerticalPadding,
            ),
            child: TextFormField(
              controller: firstNameCtrl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (lastName) {
                return nonEmptyValidator(
                  lastName,
                  errorMessage: 'Please enter your first name',
                );
              },
              decoration: const InputDecoration(
                hintText: 'First Name',
              ),
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: kVerticalPadding,
            ),
            child: TextFormField(
              controller: middleNameCtrl,
              decoration: const InputDecoration(
                hintText: 'Middle Name',
              ),
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: kVerticalPadding,
            ),
            child: TextFormField(
              controller: lastNameCtrl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (lastName) {
                return nonEmptyValidator(
                  lastName,
                  errorMessage: 'Please enter your last name',
                );
              },
              decoration: const InputDecoration(
                hintText: 'Last Name',
              ),
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
            ),
          ),
          if (user == null) ...[
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: EmailField(
                controller: emailCtrl,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: PasswordField(
                controller: passwordCtrl,
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
          Container(
            margin: const EdgeInsets.only(
              bottom: kVerticalPadding,
            ),
            child: MobileNumberField(
              controller: mobileNumberCtrl,
              hintText: 'Mobile Number',
              textInputAction: TextInputAction.next,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width / 2) -
                    kHorizontalPadding,
                margin: const EdgeInsets.only(bottom: kVerticalPadding),
                child: FilledTextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      onSumbit(
                        firstNameCtrl.text,
                        middleNameCtrl.text.isNotEmpty
                            ? middleNameCtrl.text
                            : null,
                        lastNameCtrl.text,
                        emailCtrl.text,
                        passwordCtrl.text,
                        mobileNumberCtrl.text,
                      );
                    }
                  },
                  child: const Text("Next"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
