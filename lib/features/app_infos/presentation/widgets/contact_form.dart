// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/themes/timberland_color.dart';
import '../../../../core/utils/reduce_image_byte.dart';
import '../../../../core/utils/validators/non_empty_validator.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/inquiry.dart';
import '../bloc/app_info_bloc.dart';

class ContactsPageForm extends StatefulWidget {
  const ContactsPageForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactsPageForm> createState() => _ContactsPageFormState();
}

class _ContactsPageFormState extends State<ContactsPageForm> {
  late final AuthState authState;
  final formKey = GlobalKey<FormState>();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final messageCtrl = TextEditingController();
  // final imagesCtrls = [
  //   TextEditingController(text: null),
  //   TextEditingController(text: null),
  //   TextEditingController(text: null)
  // ];
  // List<File> imageFiles = [];
  List<ImageConfig> imageConfigs = [];
  String? selectedSubject;
  bool imagesReady = true;
  // bool didCancelImageUpload = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      authState = BlocProvider.of<AuthBloc>(context).state;
      if (authState is Authenticated) {
        firstNameCtrl.text = (authState as Authenticated).user.firstName;
        lastNameCtrl.text = (authState as Authenticated).user.lastName;
        emailCtrl.text = (authState as Authenticated).user.email;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
            child: TextFormField(
              controller: firstNameCtrl,
              decoration: const InputDecoration(
                hintText: 'First Name',
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
              controller: lastNameCtrl,
              decoration: const InputDecoration(
                hintText: 'Last Name',
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
            child: DropdownButtonFormField<String>(
              items: kSubjects
                  .map(
                    (category) => DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    ),
                  )
                  .toList(),
              onChanged: (selected) {
                selectedSubject = selected ?? selectedSubject;
              },
              value: selectedSubject,
              borderRadius: BorderRadius.circular(10),
              hint: const Text('Subject'),
              decoration: const InputDecoration(),
              validator: (gender) {
                return nonEmptyValidator(gender,
                    errorMessage: 'Please select a subject');
              },
            ),
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
            child: Stack(
              children: [
                TextFormField(
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
                Align(
                  alignment: Alignment.centerRight,
                  child: PopupMenuButton(
                    padding: EdgeInsets.zero,
                    enabled: imageConfigs.length < 3,
                    icon: const Icon(
                      Icons.attach_file,
                    ),
                    onSelected: (_) {
                      // didCancelImageUpload = false;
                      showImagePicker(context);
                    },
                    itemBuilder: (ctx) {
                      return [
                        PopupMenuItem(
                          enabled: imageConfigs.length < 3,
                          value: '',
                          child: const Text('Attach Image'),
                        ),
                      ];
                    },
                  ),
                ),
              ],
            ),
          ),
          if (imageConfigs.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: kVerticalPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: imageConfigs
                    .map(
                      (image) => ExcludeFocus(
                        child: TextFormField(
                          controller: image.ctrl,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            prefixIcon: image.imageReady
                                ? const Icon(
                                    Icons.image_outlined,
                                    size: 24,
                                    color: TimberlandColor.primary,
                                  )
                                : const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: CircularProgressIndicator.adaptive(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                imageConfigs.remove(image);
                                // didCancelImageUpload = true;
                                if (imageConfigs.isEmpty) {
                                  imagesReady = true;
                                }
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.close,
                                color: TimberlandColor.text,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
            child: FilledTextButton(
              onPressed: imagesReady
                  ? () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AppInfoBloc>(context).add(
                          SendInquiryEvent(
                            inquiry: Inquiry(
                              email: emailCtrl.text,
                              firstName: firstNameCtrl.text,
                              lastName: lastNameCtrl.text,
                              subject: selectedSubject!,
                              message: messageCtrl.text,
                              images: imageConfigs
                                  .where((imageConfig) =>
                                      imageConfig.imageFile != null)
                                  .map<File>(
                                      (imageConfig) => imageConfig.imageFile!)
                                  .toList(),
                            ),
                          ),
                        );
                      }
                    }
                  : null,
              child: const Text(
                'Contact Us',
              ),
            ),
          )
        ],
      ),
    );
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).backgroundColor.withOpacity(.5),
      barrierColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        void chooseFrom({required ImageSource source}) async {
          List<XFile> images = [];
          if (source == ImageSource.camera) {
            final temp = await ImagePicker().pickImage(source: source);
            images.addAll([if (temp != null) temp]);
          } else {
            images.addAll(
                await ImagePicker().pickMultiImage(imageQuality: 10) ?? []);
          }

          if (images.length + imageConfigs.length > 3) {
            showError("You can only choose up to 3 images,");
            return;
          }
          log("message");

          for (XFile element in images) {
            imageConfigs.add(
              ImageConfig(
                imageFile: File(element.path),
              )..ctrl.text = element.name,
            );
          }

          imagesReady = false;
          showLoading(
            'Processing image/s...',
          );
          setState(() {});

          for (ImageConfig imageConfig in imageConfigs) {
            imageConfig.reduceImage(callback: () {
              if (imageConfigs.contains(imageConfig)) {
                setState(() {});
              }
              if (imageConfig == imageConfigs.last) {
                EasyLoading.dismiss();
                showToast('Image/s are ready');
                imagesReady = true;
              }
            });
          }
        }

        return ImagePickerOptionBottomSheet(
          callback: chooseFrom,
        );
      },
    );
  }
}

class ImageConfig {
  final TextEditingController ctrl = TextEditingController();
  bool imageReady = false;
  File? imageFile;
  ImageConfig({
    this.imageFile,
  });

  reduceImage({
    required VoidCallback callback,
  }) async {
    List<int> reducedImageByte = await compute(
      reduceImageByte,
      imageFile!.readAsBytesSync(),
    ).whenComplete(
      () {
        imageReady = true;
      },
    );
    imageFile = await File(imageFile!.path).writeAsBytes(
      reducedImageByte,
    );

    callback();
  }
}
