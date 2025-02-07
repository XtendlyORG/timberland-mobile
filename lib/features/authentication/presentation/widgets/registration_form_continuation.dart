// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/constants/bloodtype_dropdown_items.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_checkbox.dart';
import 'package:timberland_biketrail/core/presentation/widgets/date_picker.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/form_fields/form_fields.dart';
import 'package:timberland_biketrail/core/presentation/widgets/image_picker_options_bottomsheet.dart';
import 'package:timberland_biketrail/core/presentation/widgets/inherited_widgets/inherited_register_parameter.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/reduce_image_byte.dart';
import 'package:timberland_biketrail/core/utils/validators/non_empty_validator.dart';
import 'package:timberland_biketrail/dashboard/domain/params/update_user_detail.dart';
import 'package:timberland_biketrail/dashboard/presentation/bloc/profile_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

import '../../../booking/presentation/pages/waiver/pdf_repository.dart';
import '../../../booking/presentation/pages/waiver/pdf_view_page.dart';

class RegistrationContinuationForm extends StatefulWidget {
  final UpdateUserDetailsParams?
      user; // user will not be null when update profile
  const RegistrationContinuationForm({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<RegistrationContinuationForm> createState() => _RegistrationContinuationFormState();
}

class _RegistrationContinuationFormState extends State<RegistrationContinuationForm> {

  final formKey = GlobalKey<FormState>();
  TextEditingController birthdayCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController professionCtrl = TextEditingController();
  TextEditingController emergencyContactsCtrl = TextEditingController();
  TextEditingController imageCtrl = TextEditingController();
  TextEditingController bikeModelCtrl = TextEditingController();
  TextEditingController bikeYearCtrl = TextEditingController();
  TextEditingController bikeColorCtrl = TextEditingController();
  
  DateTime? birthday;
  String? selectedGender;
  String? selectedBloodType;
  File? imageFile;
  bool agreedToTermsOfUse = false;
  bool imageReady = true;

  // Alternative for frequent rebuild
  void handleInitForm(bool isInit) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'registerFormInit', value: isInit.toString());
  }

  void initData() async {
    const storage = FlutterSecureStorage();
    final isInit = await storage.read(key: 'registerFormInit');
    if(isInit != "true"){
      handleInitForm(true);
      bool imageReady = true;
      final registerParameter =
          InheritedRegisterParameter.of(context).registerParameter!;
      // final formKey = GlobalKey<FormState>();
      birthday = registerParameter.birthDay;
      birthdayCtrl = TextEditingController(
        text: birthday != null
            ? DateFormat.yMMMMd('en_US').format(birthday ?? DateTime.now())
            : null,
      );

      selectedGender = registerParameter.gender;
      addressCtrl = TextEditingController(
        text: registerParameter.address,
      );
      professionCtrl = TextEditingController(text: registerParameter.profession);
      selectedBloodType = registerParameter.bloodType;

      emergencyContactsCtrl =
          TextEditingController(text: registerParameter.emergencyContactInfo);
      imageCtrl = TextEditingController(
        text: registerParameter.profilePic != null
            ? 'profile_pic.${registerParameter.profilePic!.path.split('.').last}'
            : null,
      );
      imageFile = registerParameter.profilePic;
      bikeModelCtrl = TextEditingController(text: registerParameter.bikeModel);
      bikeYearCtrl = TextEditingController(text: registerParameter.bikeYear);
      bikeColorCtrl = TextEditingController(text: registerParameter.bikeColor);

      agreedToTermsOfUse = false;

      if (widget.user != null) {
        // auto fill fields with current user's informations
        selectedGender = widget.user!.gender;
        birthday = widget.user!.birthday;
        birthdayCtrl.text = birthday != null
            ? DateFormat.yMMMMd('en_US').format(birthday ?? DateTime.now())
            : '';
        selectedBloodType = widget.user!.bloodType;
        addressCtrl.text = widget.user!.address ?? '';
        professionCtrl.text = widget.user!.profession ?? '';
        emergencyContactsCtrl.text = widget.user!.emergencyContactInfo ?? '';
        bikeModelCtrl.text = widget.user!.bikeModel ?? '';
        bikeYearCtrl.text = widget.user!.bikeYear ?? '';
        bikeColorCtrl.text = widget.user!.bikeColor ?? '';
        agreedToTermsOfUse = true;
      }
    }
  }

  void validateRebuild() async {
    // const storage = FlutterSecureStorage();
    // final isInit = await storage.read(key: 'registerFormInit');
    // if(isInit != "true"){
    // }
    
    handleInitForm(true);
    bool imageReady = true;
    final registerParameter =
        InheritedRegisterParameter.of(context).registerParameter!;
    // final formKey = GlobalKey<FormState>();
    birthday = registerParameter.birthDay;
    birthdayCtrl = TextEditingController(
      text: birthday != null
          ? DateFormat.yMMMMd('en_US').format(birthday ?? DateTime.now())
          : null,
    );

    selectedGender = registerParameter.gender;
    addressCtrl = TextEditingController(
      text: registerParameter.address,
    );
    professionCtrl = TextEditingController(text: registerParameter.profession);
    selectedBloodType = registerParameter.bloodType;

    emergencyContactsCtrl =
        TextEditingController(text: registerParameter.emergencyContactInfo);
    imageCtrl = TextEditingController(
      text: registerParameter.profilePic != null
          ? 'profile_pic.${registerParameter.profilePic!.path.split('.').last}'
          : null,
    );
    imageFile = registerParameter.profilePic;
    bikeModelCtrl = TextEditingController(text: registerParameter.bikeModel);
    bikeYearCtrl = TextEditingController(text: registerParameter.bikeYear);
    bikeColorCtrl = TextEditingController(text: registerParameter.bikeColor);

    agreedToTermsOfUse = false;

    if (widget.user != null) {
      // auto fill fields with current user's informations
      selectedGender = widget.user!.gender;
      birthday = widget.user!.birthday;
      birthdayCtrl.text = birthday != null
          ? DateFormat.yMMMMd('en_US').format(birthday ?? DateTime.now())
          : '';
      selectedBloodType = widget.user!.bloodType;
      addressCtrl.text = widget.user!.address ?? '';
      professionCtrl.text = widget.user!.profession ?? '';
      emergencyContactsCtrl.text = widget.user!.emergencyContactInfo ?? '';
      bikeModelCtrl.text = widget.user!.bikeModel ?? '';
      bikeYearCtrl.text = widget.user!.bikeYear ?? '';
      bikeColorCtrl.text = widget.user!.bikeColor ?? '';
      agreedToTermsOfUse = true;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RegistrationContinuationForm oldWidget) {
    log("This is the update widget");
    // validateRebuild();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    log("This is the update dependency");
    validateRebuild();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    handleInitForm(false);
    // Dispose all controllers
    birthdayCtrl.dispose();
    addressCtrl.dispose();
    professionCtrl.dispose();
    emergencyContactsCtrl.dispose();
    imageCtrl.dispose();
    bikeModelCtrl.dispose();
    bikeYearCtrl.dispose();
    bikeColorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerParameter = InheritedRegisterParameter.of(context).registerParameter!;
    // bool imageReady = true;
    // final registerParameter =
    //     InheritedRegisterParameter.of(context).registerParameter!;
    // // final formKey = GlobalKey<FormState>();
    // birthday = registerParameter.birthDay;
    // birthdayCtrl = TextEditingController(
    //   text:
    //       birthday != null ? DateFormat.yMMMMd('en_US').format(birthday ?? DateTime.now()) : null,
    // );

    // selectedGender = registerParameter.gender;
    // addressCtrl = TextEditingController(
    //   text: registerParameter.address,
    // );
    // professionCtrl =
    //     TextEditingController(text: registerParameter.profession);
    // selectedBloodType = registerParameter.bloodType;

    // emergencyContactsCtrl =
    //     TextEditingController(text: registerParameter.emergencyContactInfo);
    // imageCtrl = TextEditingController(
    //   text: registerParameter.profilePic != null
    //       ? 'profile_pic.${registerParameter.profilePic!.path.split('.').last}'
    //       : null,
    // );
    // imageFile = registerParameter.profilePic;
    // bikeModelCtrl =
    //     TextEditingController(text: registerParameter.bikeModel);
    // bikeYearCtrl =
    //     TextEditingController(text: registerParameter.bikeYear);
    // bikeColorCtrl =
    //     TextEditingController(text: registerParameter.bikeColor);

    // agreedToTermsOfUse = false;

    // if (widget.user != null) {
    //   // auto fill fields with current user's informations
    //   selectedGender = widget.user!.gender;
    //   birthday = widget.user!.birthday;
    //   birthdayCtrl.text =
    //       birthday != null ? DateFormat.yMMMMd('en_US').format(birthday ?? DateTime.now()) : '';
    //   selectedBloodType = widget.user!.bloodType;
    //   addressCtrl.text = widget.user!.address ?? '';
    //   professionCtrl.text = widget.user!.profession ?? '';
    //   emergencyContactsCtrl.text = widget.user!.emergencyContactInfo ?? '';
    //   bikeModelCtrl.text = widget.user!.bikeModel ?? '';
    //   bikeYearCtrl.text = widget.user!.bikeYear ?? '';
    //   bikeColorCtrl.text = widget.user!.bikeColor ?? '';
    //   agreedToTermsOfUse = true;
    // }

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is OtpSent,
      listener: (context, state) {
        if ((state as OtpSent).hasError == null && state is! OtpResent) {
          context.pushNamed(
            Routes.registerVerify.name,
          );
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
                textCapitalization: TextCapitalization.words,
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
                hint: const Text('Gender *'),
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
                  validator: (value) {
                    if (birthday == null) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: CustomDatePicker(
                            isBooking: false,
                            maxDate: DateTime(
                              //LIMIT AGE BELOW 18 CANNOT REGISTER
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
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    hintText: 'Date of Birth*',
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
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: DropdownButtonFormField<String>(
                items: kBloodTypes
                    .map(
                      (category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (selected) {
                  selectedBloodType = selected ?? selectedBloodType;
                },
                value: selectedBloodType,
                borderRadius: BorderRadius.circular(10),
                hint: const Text('Blood Type'),
                decoration: const InputDecoration(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: kVerticalPadding,
              ),
              child: MobileNumberField(
                controller: emergencyContactsCtrl,
                hintText: '*Emergency Contact Number',
                textInputAction: TextInputAction.next,
              ),
            ),
            if (widget.user == null)
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
                              imageReady = false;
                              List<int> reducedImageByte = await compute(
                                reduceImageByte,
                                imageFile!.readAsBytesSync(),
                              ).whenComplete(
                                () {
                                  imageReady = true;
                                  EasyLoading.dismiss();
                                  showInfo('Image is ready');
                                },
                              );
                              imageFile = await File(image.path).writeAsBytes(
                                reducedImageByte,
                              );
                            }
                          }

                          return ImagePickerOptionBottomSheet(
                            callback: chooseFrom,
                          );
                        },
                      );
                    },
                    controller: imageCtrl,
                    enableInteractiveSelection: false,
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
            Text(
              'Only people 18 years old and above can register',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: kVerticalPadding,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: kVerticalPadding),
              width: double.infinity,
              child: FilledTextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (!agreedToTermsOfUse) {
                      showFloatingToast(
                        context,
                        'Terms of Use not accepted',
                        duration: const Duration(milliseconds: 1500),
                      );
                      return;
                    }
                    if (!imageReady) {
                      showLoading('Processing Image...');
                      return;
                    }
                    final registerParams = registerParameter.copyWith(
                      profession: professionCtrl.text.isNotEmpty
                          ? professionCtrl.text
                          : null,
                      gender: selectedGender,
                      birthDay: birthday,
                      address:
                          addressCtrl.text.isNotEmpty ? addressCtrl.text : null,
                      bloodType: selectedBloodType,
                      emergencyContactInfo:
                          emergencyContactsCtrl.text.isNotEmpty
                              ? emergencyContactsCtrl.text
                              : null,
                      bikeModel: bikeModelCtrl.text.isNotEmpty
                          ? bikeModelCtrl.text
                          : null,
                      bikeYear: bikeYearCtrl.text.isNotEmpty
                          ? bikeYearCtrl.text
                          : null,
                      bikeColor: bikeColorCtrl.text.isNotEmpty
                          ? bikeColorCtrl.text
                          : null,
                      profilePic: imageFile,
                    );
                    if (widget.user == null) {
                      BlocProvider.of<AuthBloc>(context).add(
                        RequestRegisterEvent(parameter: registerParams),
                      );
                    } else {
                      BlocProvider.of<ProfileBloc>(context).add(
                        SubmitUpdateUserDetailRequestEvent(
                          updateProfileParams:
                              UpdateUserDetailsParams.fromRegisterParams(
                            registerParams,
                          ),
                        ),
                      );
                    }
                  }
                },
                child:
                    widget.user == null ? const Text("Register") : const Text("Save"),
              ),
            ),
            if (widget.user == null)
              RepaintBoundary(
                child: CustomCheckbox(
                  onChange: (val) {
                    agreedToTermsOfUse = val;
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'By signing up you agree to our',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        const TextSpan(
                          text: '\nTerms of Use',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: ' and ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              const path =
                                  'assets/privacy_policy/ChromaWebsite-PrivacyPolicy.pdf';
                              final file = await PDFRepository.loadAsset(path);

                              openPDF(context, file);
                            },
                        ),
                      ],
                    ),
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewPage(file: file)),
      );
}