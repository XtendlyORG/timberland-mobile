import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/otp_resend_button.dart';

import '../widgets/auth_page_container.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final otpCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: Tooltip(
          message: 'Back',
          child: IconButton(
            onPressed: () {
              context.goNamed(Routes.register.name);
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
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: kToolbarHeight),
              child: Text(
                'OTP Verification',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kVerticalPadding),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: otpCtrl,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'OTP can not be empty.';
                    } else if (val.length != 6 || int.tryParse(val) == null) {
                      return 'OTP must be a 6 digit number.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your OTP',
                    suffixIcon: SizedBox(
                      width: 100,
                      child: OTPResendButton(
                        duration: 10,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final authBloc = BlocProvider.of<AuthBloc>(context);
                    authBloc.add(
                      RegisterEvent(
                        registerParameter: (authBloc.state as OtpSent)
                            .registerParameter
                            .copyWith(
                              otp: otpCtrl.text,
                            ),
                      ),
                    );
                  }
                },
                child: const Text("Validate OTP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
