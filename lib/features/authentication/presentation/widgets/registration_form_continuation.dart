// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/form_fields/email_field.dart';
import 'package:timberland_biketrail/core/presentation/widgets/form_fields/mobile_number_field.dart';
import 'package:timberland_biketrail/core/presentation/widgets/form_fields/password_field.dart';
import 'package:timberland_biketrail/core/presentation/widgets/image_picker_options_bottomsheet.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/validators/non_empty_validator.dart';
import 'package:timberland_biketrail/dashboard/presentation/bloc/profile_bloc.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/register.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/terms_of_use.dart';

class RegistrationContinuationForm extends StatelessWidget {
  final RegisterParameter registerParameter;
  final User? user; // user will not be null when update profile
  const RegistrationContinuationForm({
    Key? key,
    required this.registerParameter,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final bloodTypeCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final mobileNumberCtrl = TextEditingController();
    final emergencyContactsCtrl = TextEditingController();
    final imageCtrl = TextEditingController();
    File? imageFile;
    final bikeModelCtrl = TextEditingController();
    final bikeYearCtrl = TextEditingController();
    final bikeColorCtrl = TextEditingController();

    bool agreedToTermsOfUse = false;

    if (user != null) {
      // auto fill fields with current user's informations
      bloodTypeCtrl.text = user!.bloodType ?? '';
      emailCtrl.text = user!.email;
      mobileNumberCtrl.text = user!.mobileNumber;
      bikeModelCtrl.text = user!.bikeModel ?? '';
      bikeYearCtrl.text = user!.bikeYear ?? '';
      bikeColorCtrl.text = user!.bikeColor ?? '';
      agreedToTermsOfUse = true;
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpSent) {
          context.goNamed(Routes.otpVerification.name);
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: TextFormField(
                controller: bloodTypeCtrl,
                validator: nonEmptyValidator,
                decoration: const InputDecoration(
                  hintText: 'Blood Type',
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
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
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: MobileNumberField(
                controller: mobileNumberCtrl,
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: MobileNumberField(
                controller: emergencyContactsCtrl,
                textInputAction: TextInputAction.next,
              ),
            ),
            if (user == null)
              Container(
                margin: const EdgeInsets.only(
                  bottom: kVerticalPadding,
                ),
                child: ExcludeFocus(
                  child: TextFormField(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.transparent,
                        clipBehavior: Clip.hardEdge,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          void chooseFrom({required ImageSource source}) async {
                            XFile? image = await ImagePicker().pickImage(
                              source: source,
                            );
                            if (image != null) {
                              imageCtrl.text =
                                  'profile_pic${image.name.substring(image.name.lastIndexOf('.'))}';
                              imageFile = File(image.path);
                            }
                          }

                          return ImagePickerOptionBottomSheet(
                            callback: chooseFrom,
                          );
                        },
                      );
                    },
                    controller: imageCtrl,
                    validator: nonEmptyValidator,
                    decoration: InputDecoration(
                      hintText: 'Take a selfie',
                      suffixIcon: const Icon(Icons.ios_share_rounded),
                      prefixIcon: Image.asset(
                        'assets/icons/selfie_icon.png',
                        scale: 1.5,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: TextFormField(
                controller: bikeModelCtrl,
                validator: nonEmptyValidator,
                decoration: const InputDecoration(
                  hintText: 'Bike(model)',
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: kVerticalPadding),
                      child: TextFormField(
                        controller: bikeYearCtrl,
                        validator: nonEmptyValidator,
                        decoration: const InputDecoration(
                          hintText: 'Bike(year)',
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: kVerticalPadding,
                    height: 0,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: kVerticalPadding),
                      child: TextFormField(
                        controller: bikeColorCtrl,
                        validator: nonEmptyValidator,
                        decoration: const InputDecoration(
                          hintText: 'Bike(color)',
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: kVerticalPadding),
              width: double.infinity,
              child: FilledTextButton(
                onPressed: () {
                  if (formKey.currentState!.validate() && agreedToTermsOfUse) {
                    if (user == null) {
                      BlocProvider.of<AuthBloc>(context).add(
                        SendOtpEvent(
                          registerParameter: registerParameter.copyWith(
                            bloodType: bloodTypeCtrl.text,
                            email: emailCtrl.text,
                            password: passwordCtrl.text,
                            mobileNumber: mobileNumberCtrl.text,
                            emergencyContactInfo: emergencyContactsCtrl.text,
                            bikeModel: bikeModelCtrl.text,
                            bikeYear: bikeYearCtrl.text,
                            bikeColor: bikeColorCtrl.text,
                            profilePic: imageFile,
                          ),
                        ),
                      );
                    } else {
                      BlocProvider.of<ProfileBloc>(context)
                          .add(SubmitUpdateRequestEvent());
                    }
                  }
                  if (!agreedToTermsOfUse) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: AutoSizeText(
                          'Terms of Use not accepted.',
                          maxLines: 1,
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Register"),
              ),
            ),
            if (user == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RepaintBoundary(
                    child: TermsOfUse(
                      onChange: (val) {
                        agreedToTermsOfUse = val;
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
      ),
    );
  }
}
