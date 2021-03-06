// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/auth_page_container.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/registration_form_continuation.dart';

class RegistrationContinuationPage extends StatelessWidget {
  const RegistrationContinuationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0,
            leading: Tooltip(
              message: 'Back',
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: AuthPageContainer(
            child: Column(
              children: const [
                RegistrationContinuationForm(),
                SizedBox(
                  height: kVerticalPadding,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
