// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/date_picker.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/form_fields/form_fields.dart';
import 'package:timberland_biketrail/core/presentation/widgets/form_fields/mobile_number_field.dart';
import 'package:timberland_biketrail/core/presentation/widgets/image_picker_options_bottomsheet.dart';
import 'package:timberland_biketrail/core/presentation/widgets/inherited_widgets/inherited_register_parameter.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/validators/non_empty_validator.dart';
import 'package:timberland_biketrail/dashboard/presentation/bloc/profile_bloc.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/update_profile.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/widgets/terms_of_use.dart';

class RegistrationContinuationForm extends StatelessWidget {
  final UpdateProfileParams? user; // user will not be null when update profile
  const RegistrationContinuationForm({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerParameter =
        InheritedRegisterParameter.of(context).registerParameter!;
    final formKey = GlobalKey<FormState>();
    final passwordCtrl = TextEditingController();
    DateTime? birthday = registerParameter.birthDay;
    final birthdayCtrl = TextEditingController(
      text:
          birthday != null ? DateFormat.yMMMMd('en_US').format(birthday) : null,
    );

    String? selectedGender = registerParameter.gender;
    final addressCtrl = TextEditingController(
      text: registerParameter.address,
    );
    final professionCtrl =
        TextEditingController(text: registerParameter.profession);
    final bloodTypeCtrl =
        TextEditingController(text: registerParameter.bloodType);

    final emergencyContactsCtrl =
        TextEditingController(text: registerParameter.emergencyContactInfo);
    final imageCtrl = TextEditingController(
      text: registerParameter.profilePic != null
          ? 'profile_pic.${registerParameter.profilePic!.path.split('.').last}'
          : null,
    );
    File? imageFile = registerParameter.profilePic;
    final bikeModelCtrl =
        TextEditingController(text: registerParameter.bikeModel);
    final bikeYearCtrl =
        TextEditingController(text: registerParameter.bikeYear);
    final bikeColorCtrl =
        TextEditingController(text: registerParameter.bikeColor);

    bool agreedToTermsOfUse = false;

    if (user != null) {
      // auto fill fields with current user's informations
      selectedGender = user!.gender;
      birthday = user!.birthDay;
      birthdayCtrl.text =
          birthday != null ? DateFormat.yMMMMd('en_US').format(birthday) : '';
      bloodTypeCtrl.text = user!.bloodType ?? '';
      addressCtrl.text = user!.address ?? '';
      professionCtrl.text = user!.profession ?? '';
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
                controller: professionCtrl,
                decoration: const InputDecoration(
                  hintText: 'Profession',
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: DropdownButtonFormField<String>(
                items: kGenderDropDownItems
                    .map(
                      (category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (selected) {
                  selectedGender = selected ?? selectedGender;
                },
                value: selectedGender,
                borderRadius: BorderRadius.circular(10),
                hint: const Text('Gender'),
                decoration: const InputDecoration(),
                validator: (gender) {
                  return nonEmptyValidator(gender,
                      errorMessage: 'Please select a gender');
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: ExcludeFocus(
                child: TextFormField(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: CustomDatePicker(
                            maxDate: DateTime(
                              DateTime.now().year - 18,
                              DateTime.now().month,
                              DateTime.now().day,
                            ),
                            onSumbit: (value) {
                              if (value is DateTime) {
                                birthday = value;
                                log(birthday.toString());
                                birthdayCtrl.text =
                                    DateFormat.yMMMMd('en_US').format(value);
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                  controller: birthdayCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Date of Birth',
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: TextFormField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: 'Address',
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: TextFormField(
                controller: bloodTypeCtrl,
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
              child: MobileNumberField(
                controller: emergencyContactsCtrl,
                validator: (_) => null, //disable validator
                hintText: 'Emergency Contact Number',
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
            if (user != null)
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
              margin: const EdgeInsets.only(bottom: kVerticalPadding),
              width: double.infinity,
              child: FilledTextButton(
                onPressed: () {
                  if (formKey.currentState!.validate() && agreedToTermsOfUse) {
                    if (user == null) {
                      BlocProvider.of<AuthBloc>(context).add(
                        SendOtpEvent(
                          registerParameter: registerParameter.copyWith(
                            profession: professionCtrl.text.isNotEmpty
                                ? professionCtrl.text
                                : null,
                            gender: selectedGender,
                            birthDay: birthday,
                            address: addressCtrl.text.isNotEmpty
                                ? addressCtrl.text
                                : null,
                            bloodType: bloodTypeCtrl.text.isNotEmpty
                                ? bloodTypeCtrl.text
                                : null,
                            emergencyContactInfo:
                                emergencyContactsCtrl.text.isNotEmpty
                                    ? emergencyContactsCtrl.text
                                    : null,
                            bikeModel: bikeModelCtrl.text.isNotEmpty?bikeModelCtrl.text:null,
                            bikeYear: bikeYearCtrl.text.isNotEmpty?bikeYearCtrl.text:null,
                            bikeColor: bikeColorCtrl.text.isNotEmpty?bikeColorCtrl.text:null,
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
                child:
                    user == null ? const Text("Register") : const Text("Save"),
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
