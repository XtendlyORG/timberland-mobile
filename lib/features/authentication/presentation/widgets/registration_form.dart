// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/password_field.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  String? validateEmail(String? email) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!regex.hasMatch(email)) {
      return 'Invalid email address.';
    }
    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailCtrl = TextEditingController();
    final firstNameCtrl = TextEditingController();
    final lastNameCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    bool agreedToTermsOfUse = false;
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: kFieldPadding,
            ),
            child: TextFormField(
              controller: firstNameCtrl,
              validator: validateName,
              decoration: const InputDecoration(
                hintText: 'First Name',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: kFieldPadding,
            ),
            child: TextFormField(
              controller: lastNameCtrl,
              validator: validateName,
              decoration: const InputDecoration(
                hintText: 'Last Name',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: kFieldPadding,
            ),
            child: TextFormField(
              controller: emailCtrl,
              validator: validateEmail,
              decoration: const InputDecoration(
                hintText: 'Email Address',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: kFieldPadding,
            ),
            child: PasswordField(controller: passwordCtrl),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: kFieldPadding),
            child: TextButton(
              onPressed: () {
                if (formKey.currentState!.validate() & agreedToTermsOfUse) {
                  //TODO: Call login here
                  log('Register');
                }
                if (!agreedToTermsOfUse) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Terms of Use not accepted.'),
                    ),
                  );
                }
              },
              child: const Text("Register"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                child: TermsOfUse(
                  onChange: (val) {
                    agreedToTermsOfUse = val;
                    log(agreedToTermsOfUse.toString());
                  },
                ),
              ),
              Text.rich(
                const TextSpan(
                  children: [
                    TextSpan(
                      text: 'By signing up you agree to our',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: '\nTerms of Use',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TermsOfUse extends StatefulWidget {
  final void Function(bool val) onChange;
  const TermsOfUse({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  late bool agreedToTermsOfUse;

  @override
  void initState() {
    super.initState();
    agreedToTermsOfUse = false;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: agreedToTermsOfUse,
      onChanged: (val) {
        setState(() {
          agreedToTermsOfUse = !agreedToTermsOfUse;
        });
        widget.onChange(agreedToTermsOfUse);
      },
    );
  }
}
