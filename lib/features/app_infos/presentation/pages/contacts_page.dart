// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimberlandScaffold(
      titleText: 'Contact Us',
      showNavbar: Session().isLoggedIn,
      body: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding, vertical: kVerticalPadding * 3),
        child: ContactsPageForm(),
      ),
    );
  }
}

class ContactsPageForm extends StatelessWidget {
  const ContactsPageForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authState = BlocProvider.of<AuthBloc>(context).state;
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final subjectCtrl = TextEditingController();
    final messageCtrl = TextEditingController();

    if(authState is Authenticated){
      nameCtrl.text = '${authState.user.firstName} ${authState.user.lastName}';
      emailCtrl.text = authState.user.email;
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          EmailField(controller: emailCtrl),
          const SizedBox(
            height: kVerticalPadding,
          ),
          TextFormField(
            controller: subjectCtrl,
            validator: (subject) {
              if (subject == null || subject.isEmpty) {
                return 'Subject can not be empty';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Subject',
            ),
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          TextFormField(
            controller: messageCtrl,
            maxLines: 5,
            validator: (message) {
              if (message == null || message.isEmpty) {
                return 'Message can not be empty';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Message',
            ),
          ),
          const SizedBox(height: kVerticalPadding),
          SizedBox(
            width: double.infinity,
            child: FilledTextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // TODO: Call contact us event here
                }
              },
              child: const Text(
                'Contact Us',
              ),
            ),
          )
        ],
      ),
    );
  }
}
