// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/date_picker.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/register.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  String? validateEmail(String? email) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!regex.hasMatch(email)) {
      return 'Invalid email address.';
    }
    return null;
  }

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
    String? selectedGender;
    final birthdayCtrl = TextEditingController();
    DateTime? birthday;
    final addressCtrl = TextEditingController();
    final professionCtrl = TextEditingController();

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
                      context.pushNamed(
                        Routes.registerContinuation.name,
                        extra: RegisterParameter(
                          firstName: firstNameCtrl.text,
                          middleName: middleNameCtrl.text,
                          lastName: lastNameCtrl.text,
                          gender: selectedGender!,
                          birthDay: DateTime.now(),
                          address: addressCtrl.text,
                          profession: professionCtrl.text,
                        ),
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
