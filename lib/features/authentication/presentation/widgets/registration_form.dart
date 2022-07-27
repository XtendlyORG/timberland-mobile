// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/date_picker.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({
    Key? key,
    this.user,
    required this.onSumbit,
  }) : super(key: key);

  final void Function(
    String firstName,
    String? middleName,
    String lastName,
    String selectedGender,
    DateTime birthday,
    String? address,
    String? profession,
  ) onSumbit;
  // final TextEditingController? firstNameController;
  // final TextEditingController? middleNameController;
  // final TextEditingController? lastNameController;
  // final String? selectedGender;
  // final TextEditingController? birthdayController;
  // final DateTime? birthday;
  // final TextEditingController? addressController;
  // final TextEditingController? professionController;
  final User? user;

  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final firstNameCtrl = TextEditingController();
    final middleNameCtrl = TextEditingController();
    final lastNameCtrl = TextEditingController();
    String? _selectedGender;
    final birthdayCtrl = TextEditingController();
    DateTime? _birthday;
    final addressCtrl = TextEditingController();
    final professionCtrl = TextEditingController();

    if (user != null) {
      firstNameCtrl.text = user!.firstName;
      lastNameCtrl.text = user!.lastName;
      middleNameCtrl.text = user!.middleName ?? '';
      _selectedGender = user!.gender;
      _birthday = user!.birthday;
      birthdayCtrl.text = DateFormat.yMMMMd('en_US').format(_birthday);
      addressCtrl.text = user!.address;
      professionCtrl.text = user!.profession;
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: kVerticalPadding,
            ),
            child: TextFormField(
              controller: firstNameCtrl,
              validator: validateName,
              decoration: const InputDecoration(
                hintText: 'First Name',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: kVerticalPadding,
            ),
            child: TextFormField(
              controller: middleNameCtrl,
              decoration: const InputDecoration(
                hintText: 'Middle Name',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: kVerticalPadding,
            ),
            child: TextFormField(
              controller: lastNameCtrl,
              validator: validateName,
              decoration: const InputDecoration(
                hintText: 'Last Name',
              ),
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
                _selectedGender = selected ?? _selectedGender;
              },
              value: _selectedGender,
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
                              _birthday = value;
                              log(_birthday.toString());
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
                validator: validateName,
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
              validator: (val) {},
              decoration: const InputDecoration(
                hintText: 'Address',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: kVerticalPadding,
            ),
            child: TextFormField(
              controller: professionCtrl,
              validator: (val) {},
              decoration: const InputDecoration(
                hintText: 'Profession',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width / 2) -
                    kHorizontalPadding,
                margin: const EdgeInsets.only(bottom: kVerticalPadding),
                child: FilledTextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      onSumbit(
                        firstNameCtrl.text,
                        middleNameCtrl.text,
                        lastNameCtrl.text,
                        _selectedGender!,
                        _birthday!,
                        addressCtrl.text,
                        professionCtrl.text,
                      );
                    }
                  },
                  child: const Text("Next"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
