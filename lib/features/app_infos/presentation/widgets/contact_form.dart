import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/padding.dart';
import '../../../../core/presentation/widgets/state_indicators/state_indicators.dart';
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
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final messageCtrl = TextEditingController();
  final imageCtrl = TextEditingController();
  String? selectedSubject;
  File? imageFile;
  bool imageReady = true;
  bool didCancelImageUpload = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      authState = BlocProvider.of<AuthBloc>(context).state;
      if (authState is Authenticated) {
        nameCtrl.text =
            '${(authState as Authenticated).user.firstName} ${(authState as Authenticated).user.lastName}';
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
                    enabled: imageFile == null,
                    icon: const Icon(
                      Icons.attach_file,
                    ),
                    onSelected: (_) {
                      didCancelImageUpload = false;
                      showImagePicker(context);
                    },
                    itemBuilder: (ctx) {
                      return [
                        PopupMenuItem(
                          enabled: imageFile == null,
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
          if (imageFile != null)
            Padding(
              padding: const EdgeInsets.only(top: kVerticalPadding),
              child: ExcludeFocus(
                child: TextFormField(
                  controller: imageCtrl,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    prefixIcon: imageReady
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
                        imageFile = null;
                        imageCtrl.clear();
                        didCancelImageUpload = true;
                        imageReady = true;
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
            ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: kMaxWidthMobile),
            child: FilledTextButton(
              onPressed: imageReady
                  ? () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AppInfoBloc>(context).add(
                          SendInquiryEvent(
                            inquiry: Inquiry(
                              email: emailCtrl.text,
                              fullName: nameCtrl.text,
                              subject: selectedSubject!,
                              message: messageCtrl.text,
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
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        void chooseFrom({required ImageSource source}) async {
          XFile? image = await ImagePicker().pickImage(
            source: source,
          );
          if (image != null) {
            imageCtrl.text = image.name;
            imageFile = File(image.path);
            imageReady = false;
            setState(() {});
            List<int> reducedImageByte = await compute(
              reduceImageByte,
              imageFile!.readAsBytesSync(),
            ).whenComplete(
              () {
                if (!didCancelImageUpload) {
                  imageReady = true;
                  EasyLoading.dismiss();
                  showToast('Image is ready');
                  setState(() {});
                }
              },
            );
            if (!didCancelImageUpload) {
              imageFile = await File(image.path).writeAsBytes(
                reducedImageByte,
              );
            }
          }
        }

        return ImagePickerOptionBottomSheet(
          callback: chooseFrom,
        );
      },
    );
  }
}
