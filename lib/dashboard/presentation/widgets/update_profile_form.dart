import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/presentation/widgets/inherited_widgets/inherited_register_parameter.dart';
import '../../../core/presentation/widgets/state_indicators/state_indicators.dart';
import '../../../core/router/router.dart';
import '../../../core/utils/reduce_image_byte.dart';
import '../../../features/authentication/domain/entities/user.dart';
import '../../../features/authentication/domain/params/register.dart';
import '../../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../../../features/authentication/presentation/widgets/registration_form.dart';
import '../../../features/authentication/presentation/widgets/registration_form_continuation.dart';
import '../../domain/params/update_user_detail.dart';
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
    bool imageReady = true;
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) {
        if (current is ProfileUpdateRequestSent) {
          showLoading(current.loadingMessage);
        }
        if (current is ProfileUpdated) {
          showSuccess(current.message);

          BlocProvider.of<AuthBloc>(context).add(
            UpdateUser(newUser: current.user),
          );

          context.goNamed(Routes.profile.name);
        }
        if (current is OTPToUpdateSent) {
          context.pushNamed(Routes.verifyUpdateOtp.name);
        }
        if (current is ProfileUpdateError) {
          showError(current.errorMessage);
          context.goNamed(Routes.profile.name);
        }

        return current is! ProfileUpdateRequestSent &&
            current is! ProfileInitial &&
            current is! ProfileUpdated &&
            current is! ProfileUpdateError;
      },
      builder: (context, state) {
        if (state is ProfileInitial) {
          BlocProvider.of<ProfileBloc>(context).add(UpdateUserDetailEvent(
            user: UpdateUserDetailsParams(
              firstName: user.firstName,
              middleName: user.middleName,
              lastName: user.lastName,
              mobileNumber: user.mobileNumber,
              emergencyContactInfo: user.emergencyContactInfo,
              address: user.address,
              gender: user.gender,
              birthday: user.birthday,
              bloodType: user.bloodType,
              profession: user.profession,
              bikeColor: user.bikeColor,
              bikeModel: user.bikeModel,
              bikeYear: user.bikeYear,
            ),
          ));
        }
        if (state is UpdatingUserDetail && state.pageNum == 1) {
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
                    onChange: (imageFile, imagePath) async {
                      imageReady = false;
                      List<int> reducedImageByte = await compute(
                        reduceImageByte,
                        imageFile.readAsBytesSync(),
                      ).whenComplete(
                        () {
                          imageReady = true;
                          EasyLoading.dismiss();
                          showInfo('Image is ready');
                        },
                      );
                      newImageFile = await File(imagePath).writeAsBytes(
                        reducedImageByte,
                      );
                    }),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                Builder(
                  builder: (ctx) {
                    return RegistrationForm(
                      user: state.updatedUser,
                      onSumbit: (
                        String firstName,
                        String? middleName,
                        String lastName,
                        String email,
                        String password,
                        String mobileNumber,
                      ) async {
                        if (imageReady) {
                          BlocProvider.of<ProfileBloc>(context).add(
                            NavigateToNextPage(
                              updatedUser: state.updatedUser.copyWith(
                                firstName: firstName,
                                lastName: lastName,
                                middleName: middleName ?? '',
                                email: email,
                                mobileNumber: mobileNumber,
                                profilePic: newImageFile,
                              ),
                            ),
                          );
                        } else {
                          showLoading('Processing Image...');
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is UpdatingUserDetail && state.pageNum == 2) {
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
                email: '',
                password: '',
                mobileNumber: state.updatedUser.mobileNumber,
                profilePic: state.updatedUser.profilePic,
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
