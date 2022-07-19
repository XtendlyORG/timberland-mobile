// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/image_picker_options_bottomsheet.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/register.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/terms_of_use.dart';

class RegistrationContinuationForm extends StatelessWidget {
  final RegisterParameter registerParameter;
  const RegistrationContinuationForm({
    Key? key,
    required this.registerParameter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final bloodTypeCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final mobileNumberCtrl = TextEditingController();
    final emergencyContactsCtrl = TextEditingController();
    final imageCtrl = TextEditingController();
    File? imageFile;
    final bikeModelCtrl = TextEditingController();
    final bikeYearCtrl = TextEditingController();
    final bikeColorCtrl = TextEditingController();
    Color? bikeColor;

    bool agreedToTermsOfUse = false;
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
                validator: (val) {},
                decoration: const InputDecoration(
                  hintText: 'Blood Type',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                  hintText: 'Email Address',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: TextFormField(
                controller: mobileNumberCtrl,
                validator: (val) {},
                decoration: const InputDecoration(
                  hintText: 'Mobile Number',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: TextFormField(
                controller: emergencyContactsCtrl,
                validator: (val) {},
                decoration: const InputDecoration(
                  hintText: 'Emergency contact information',
                ),
              ),
            ),
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
                  validator: (val) {},
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
                validator: (val) {},
                decoration: const InputDecoration(
                  hintText: 'Bike(model)',
                ),
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
                        validator: (val) {},
                        decoration: const InputDecoration(
                          hintText: 'Bike(year)',
                        ),
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
                        validator: (val) {},
                        decoration: const InputDecoration(
                          hintText: 'Bike(color)',
                        ),
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
                    BlocProvider.of<AuthBloc>(context).add(
                      SendOtpEvent(
                        registerParameter: registerParameter.copyWith(
                          bloodType: bloodTypeCtrl.text,
                          email: emailCtrl.text,
                          mobileNumber: mobileNumberCtrl.text,
                          emergencyContactInfo: emergencyContactsCtrl.text,
                          bikeModel: bikeModelCtrl.text,
                          bikeYear: bikeYearCtrl.text,
                          bikeColor: bikeColor,
                          profilePic: imageFile,
                        ),
                      ),
                    );
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
      ),
    );
  }
}
