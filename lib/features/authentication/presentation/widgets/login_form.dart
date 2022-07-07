import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/usecases/login.dart';
import '../bloc/auth_bloc.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import 'password_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text('Welcome to Timberland Mountain Bike Park!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(
            height: 27,
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
            child: RepaintBoundary(
              child: PasswordField(controller: passwordCtrl),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: kFieldPadding),
            child: TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  //TODO: Call login here
                  log('Login');
                  BlocProvider.of<AuthBloc>(context).add(
                    LoginEvent(
                      loginParameter: LoginParameter(
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                      ),
                    ),
                  );
                }
              },
              child: const Text("Log in"),
            ),
          ),
          GestureDetector(
            onTap: () {
              //TODO: Call forgot password here
              log('Forgot password');
            },
            child: Text(
              'Forgot your password?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: kFieldPadding),
            child: Row(
              children: const [
                Expanded(
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text('or'),
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularIconButton(
                assetImagePath: 'assets/icons/facebook.png',
                onTap: () {
                  //TODO: Call Facebook Auth here
                },
              ),
              const SizedBox(width: 8),
              CircularIconButton(
                assetImagePath: 'assets/icons/google.png',
                onTap: () {
                  //TODO: Call Google Auth here
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
