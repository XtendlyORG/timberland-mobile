// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/core/utils/validators/non_empty_validator.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/inquiry.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/bloc/app_info_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppInfoBloc, AppInfoState>(
      listenWhen: (previous, current) => current is ContactState,
      listener: (context, state) {
        if (state is SendingInquiry) {
          showLoading('Sending your message...');
        }

        if (state is InquiryError) {
          showError(state.errorMessage);
        }
        if (state is InquirySent) {
          showSuccess('Your message was sent');
        }
      },
      child: TimberlandScaffold(
        titleText: 'Contact Us',
        extendBodyBehindAppbar: true,
        showNavbar: Session().isLoggedIn,
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding * 3,
          ),
          constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
          child: const ContactsPageForm(),
        ),
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

    if (authState is Authenticated) {
      nameCtrl.text = '${authState.user.firstName} ${authState.user.lastName}';
      emailCtrl.text = authState.user.email;
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
            child: TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
            child: EmailField(
              controller: emailCtrl,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
            child: TextFormField(
              controller: subjectCtrl,
              validator: (subject) {
                return nonEmptyValidator(
                  subject,
                  errorMessage: 'Please enter a subject',
                );
              },
              decoration: const InputDecoration(
                hintText: 'Subject',
              ),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
            ),
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
            child: TextFormField(
              controller: messageCtrl,
              maxLines: 5,
              maxLength: 255,
              validator: (message) {
                return nonEmptyValidator(
                  message,
                  errorMessage: 'Please enter a message',
                );
              },
              decoration: const InputDecoration(
                hintText: 'Message',
              ),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.newline,
            ),
          ),
          const SizedBox(height: kVerticalPadding),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
            child: FilledTextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<AppInfoBloc>(context).add(
                    SendInquiryEvent(
                      inquiry: Inquiry(
                        email: emailCtrl.text,
                        fullName: nameCtrl.text,
                        subject: subjectCtrl.text,
                        message: messageCtrl.text,
                      ),
                    ),
                  );
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
