import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../features/authentication/domain/entities/user.dart';
import 'update_profile_pic.dart';

class UpdateProfileForm extends StatelessWidget {
  final User user;
  const UpdateProfileForm({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genders = ['Male', 'Female', 'Other'];
    String selectedGender = 'Male';
    final formKey = GlobalKey<FormState>();
    final firstNameCtrl = TextEditingController(text: user.firstName);
    final lastNameCtrl = TextEditingController(text: user.lastName);
    final addressCtrl = TextEditingController(text: 'Initial User address');
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding, vertical: kVerticalPadding * 2),
        child: Column(
          children: [
            const UpdateProfilePic(),
            const SizedBox(
              height: kVerticalPadding * 2,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kVerticalPadding),
              child: TextFormField(
                controller: firstNameCtrl,
                decoration: const InputDecoration(
                  hintText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kVerticalPadding),
              child: TextFormField(
                controller: lastNameCtrl,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kVerticalPadding),
              child: DropdownButtonFormField<String>(
                items: genders
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
                  if (gender == null) {
                    return 'Please select a gender';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kVerticalPadding),
              child: TextFormField(
                controller: addressCtrl,
                decoration: const InputDecoration(
                  hintText: 'Address',
                ),
                validator: (address) {
                  if (address == null || address.isEmpty) {
                    return 'Address field can not be empty';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
                child: const Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
