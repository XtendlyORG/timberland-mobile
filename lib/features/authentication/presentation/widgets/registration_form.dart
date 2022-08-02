// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/date_picker.dart';
import 'package:timberland_biketrail/core/presentation/widgets/filled_text_button.dart';
import 'package:timberland_biketrail/core/utils/validators/non_empty_validator.dart';
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
  final User? user;

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

    if (user != null) {
      firstNameCtrl.text = user!.firstName;
      lastNameCtrl.text = user!.lastName;
      middleNameCtrl.text = user!.middleName ?? '';
      selectedGender = user!.gender;
      birthday = user!.birthday;
      if (birthday != null) {
        birthdayCtrl.text = DateFormat.yMMMMd('en_US').format(birthday);
      }
      if (user!.address != null) {
        addressCtrl.text = user!.address!;
      }
      if (user!.profession != null) {
        professionCtrl.text = user!.profession!;
      }
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
              validator: nonEmptyValidator,
              decoration: const InputDecoration(
                hintText: 'First Name',
              ),
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.next,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: kVerticalPadding,
            ),
            child: TextFormField(
              controller: lastNameCtrl,
              validator: nonEmptyValidator,
              decoration: const InputDecoration(
                hintText: 'Last Name',
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
                validator: nonEmptyValidator,
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
              validator: nonEmptyValidator,
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
              controller: professionCtrl,
              validator: nonEmptyValidator,
              decoration: const InputDecoration(
                hintText: 'Profession',
              ),
              textInputAction: TextInputAction.next,
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
                        selectedGender!,
                        birthday!,
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
