// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:timberland_biketrail/core/presentation/widgets/image_picker_options_bottomsheet.dart';

class UpdateProfilePic extends StatefulWidget {
  const UpdateProfilePic({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePic> createState() => _UpdateProfilePicState();
}

class _UpdateProfilePicState extends State<UpdateProfilePic> {
  File? fileImage;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(.2),
          builder: (context) {
            return ImagePickerOptionBottomSheet(
              fromCameraCallback: () async {
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  setState(() {
                    fileImage = File(image.path);
                  });
                }
              },
              fromGalleryCallback: () async {
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  setState(() {
                    fileImage = File(image.path);
                  });
                }
              },
            );
          },
        );
      },
      child: SizedBox.square(
        dimension: 70,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage:
                  fileImage != null ? Image.file(fileImage!).image : null,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(59),
                  color: Theme.of(context).backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(2, 4),
                      color: Colors.black.withOpacity(
                        0.3,
                      ),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
