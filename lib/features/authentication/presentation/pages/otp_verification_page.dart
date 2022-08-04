import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/filled_text_button.dart';
import '../../../../core/router/router.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_page_container.dart';
import '../widgets/otp_resend_button.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final otpCtrl = TextEditingController();
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return WillPopScope(
      onWillPop: () async {
        context.goNamed(
          Routes.registerContinuation.name,
          extra: (authBloc.state as OtpSent).registerParameter,
        );
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0,
            leading: Tooltip(
              message: 'Back',
              child: IconButton(
                onPressed: () {
                  context.goNamed(
                    Routes.registerContinuation.name,
                    extra: (authBloc.state as OtpSent).registerParameter,
                  );
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
                      maxLength: 6,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'OTP can not be empty.';
                        } else if (val.length != 6 ||
                            int.tryParse(val) == null) {
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
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      autofocus: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledTextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
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
        ),
      ),
    );
  }
}
