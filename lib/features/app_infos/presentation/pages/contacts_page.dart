// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';

import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/utils/email_validator.dart';
import 'package:timberland_biketrail/core/utils/session.dart';

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
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final messageCtrl = TextEditingController();
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
            child: TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // TODO: Call contact us event here
                }
              },
              child: Text(
                'Contact Us',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
