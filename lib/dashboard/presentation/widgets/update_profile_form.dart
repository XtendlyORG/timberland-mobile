import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/presentation/widgets/inherited_widgets/inherited_register_parameter.dart';
import '../../../core/presentation/widgets/snackbar_content/loading_snackbar_content.dart';
import '../../../core/presentation/widgets/snackbar_content/show_snackbar.dart';
import '../../../core/presentation/widgets/timberland_scaffold.dart';
import '../../../core/router/router.dart';
import '../../../core/utils/reduce_image_byte.dart';
import '../../../features/authentication/domain/entities/user.dart';
import '../../../features/authentication/domain/params/register.dart';
import '../../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../../../features/authentication/presentation/widgets/otp_validation_form.dart';
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: LoadingSnackBarContent(
                loadingMessage: current.loadingMessage,
              ),
            ),
          );
        }
        if (current is ProfileUpdated) {
          showSnackBar(
            SnackBar(
              content: const AutoSizeText('Profile Updated'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: kHorizontalPadding,
              ),
            ),
          );

          BlocProvider.of<AuthBloc>(context).add(
            UpdateUser(newUser: current.user),
          );

          context.goNamed(Routes.profile.name);
        }
        if (current is OTPToUpdateSent) {
          context.pushNamed(Routes.verifyUpdateOtp.name);
        }
        if (current is ProfileUpdateError) {
          showSnackBar(
            SnackBar(
              content: AutoSizeText(current.errorMessage),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: kHorizontalPadding,
              ),
            ),
          );
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
                      ).whenComplete(() => imageReady = true);
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
                        log(newImageFile?.path.toString() ?? "no image");
                        if (imageReady) {
                          BlocProvider.of<ProfileBloc>(context).add(
                            NavigateToNextPage(
                              updatedUser: state.updatedUser.copyWith(
                                firstName: firstName,
                                lastName: lastName,
                                middleName: middleName??'',
                                email: email,
                                mobileNumber: mobileNumber,
                                profilePic: newImageFile,
                              ),
                            ),
                          );
                        } else {
                          showSnackBar(
                            SnackBar(
                              content: const AutoSizeText(
                                'Processing Image...',
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              margin: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                                bottom: kHorizontalPadding,
                              ),
                            ),
                          );
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

class VerifyUpdateOtpPage extends StatelessWidget {
  const VerifyUpdateOtpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimberlandScaffold(
      body: OtpVerificationForm(
        onResend: () {
          //TODO: call resend otp to update profile
        },
        onSubmit: ((otp) {
          log(otp);
        }),
      ),
    );
  }
}
