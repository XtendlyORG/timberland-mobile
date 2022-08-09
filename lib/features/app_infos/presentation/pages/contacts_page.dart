// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/snackbar_content/loading_snackbar_content.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
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
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: LoadingSnackBarContent(
                    loadingMessage: 'Sending your message...'),
              ),
            );
        }
        
        if (state is InquiryError) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: AutoSizeText(
                  state.errorMessage,
                ),
              ),
            );
        }
        if (state is InquirySent) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: AutoSizeText(
                  'Your message was sent.',
                ),
              ),
            );
        }
      },
      child: TimberlandScaffold(
        titleText: 'Contact Us',
        showNavbar: Session().isLoggedIn,
        body: const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kHorizontalPadding, vertical: kVerticalPadding * 3),
          child: ContactsPageForm(),
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
          TextFormField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          EmailField(
            controller: emailCtrl,
            textInputAction: TextInputAction.next,
          ),
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
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
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
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.newline,
          ),
          const SizedBox(height: kVerticalPadding),
          SizedBox(
            width: double.infinity,
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
