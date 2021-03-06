import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/presentation/widgets/inherited_widgets/inherited_register_parameter.dart';
import '../../../features/authentication/domain/entities/user.dart';
import '../../../features/authentication/domain/params/register.dart';
import '../../../features/authentication/domain/params/update_profile.dart';
import '../../../features/authentication/presentation/widgets/registration_form.dart';
import '../../../features/authentication/presentation/widgets/registration_form_continuation.dart';
import '../bloc/profile_bloc.dart';
import 'update_profile_pic.dart';

class UpdateProfileForm extends StatelessWidget {
  final User user;
  const UpdateProfileForm({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File? newImageFile;
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) {
        if (current is ProfileInitial) {
          BlocProvider.of<ProfileBloc>(context).add(UpdateProfileEvent(
            user: UpdateProfileParams(
              firstName: user.firstName,
              middleName: user.middleName,
              lastName: user.lastName,
              email: user.email,
              mobileNumber: user.mobileNumber,
              address: user.address,
              gender: user.gender,
              birthDay: user.birthday,
              bloodType: user.bloodType,
              profession: user.profession,
              bikeColor: user.bikeColor,
              bikeModel: user.bikeModel,
              bikeYear: user.bikeYear,
            ),
          ));
        }
        return current is! ProfileUpdated && current is! ProfileInitial;
      },
      builder: (context, state) {
        if (state is ProfileInitial) {
          BlocProvider.of<ProfileBloc>(context).add(UpdateProfileEvent(
            user: UpdateProfileParams(
              firstName: user.firstName,
              middleName: user.middleName,
              lastName: user.lastName,
              email: user.email,
              mobileNumber: user.mobileNumber,
              address: user.address,
              gender: user.gender,
              birthDay: user.birthday,
              bloodType: user.bloodType,
              profession: user.profession,
              bikeColor: user.bikeColor,
              bikeModel: user.bikeModel,
              bikeYear: user.bikeYear,
            ),
          ));
        }
        if (state is UpdatingProfile && state.pageNum == 1) {
          return Padding(
            padding: const EdgeInsets.only(
                top: kHorizontalPadding,
                left: kHorizontalPadding,
                right: kHorizontalPadding),
            child: Column(
              children: [
                UpdateProfilePic(
                    user: user,
                    profilePic: state.updatedUser.profilePic,
                    onChange: (imageFile) {
                      newImageFile = imageFile;
                    }),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                Builder(builder: (ctx) {
                  return RegistrationForm(
                    user: state.updatedUser,
                    onSumbit: (
                      String firstName,
                      String? middleName,
                      String lastName,
                      String email,
                      String password,
                      String mobileNumber,
                    ) {
                      BlocProvider.of<ProfileBloc>(context).add(
                        NavigateToNextPage(
                          updatedUser: state.updatedUser.copyWith(
                            firstName: firstName,
                            lastName: lastName,
                            middleName: middleName,
                            email: email,
                            mobileNumber: mobileNumber,
                            profilePic: newImageFile,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          );
        } else if (state is UpdatingProfile && state.pageNum == 2) {
          return Padding(
            padding: const EdgeInsets.only(
                top: kHorizontalPadding,
                left: kHorizontalPadding,
                right: kHorizontalPadding),
            child: InheritedRegisterParameter(
              registerParameter: RegisterParameter(
                firstName: state.updatedUser.firstName,
                middleName: state.updatedUser.middleName,
                lastName: state.updatedUser.lastName,
                email: state.updatedUser.email,
                password: '',
                mobileNumber: state.updatedUser.mobileNumber,
              ),
              child: RegistrationContinuationForm(
                user: state.updatedUser,
              ),
            ),
          );
        }
        return SizedBox(
          child: Text(state.toString()),
        );
      },
    );
  }
}
