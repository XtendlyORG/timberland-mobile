import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../features/authentication/domain/entities/user.dart';
import '../../../features/authentication/domain/usecases/register.dart';
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          BlocProvider.of<ProfileBloc>(context)
              .add(UpdateProfileEvent(user: user));
        }
        if (state is UpdatingProfile && state.pageNum == 1) {
          return Padding(
            padding: const EdgeInsets.only(
                top: kHorizontalPadding,
                left: kHorizontalPadding,
                right: kHorizontalPadding),
            child: Column(
              children: [
                const UpdateProfilePic(),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                Builder(builder: (ctx) {
                  return RegistrationForm(
                    user: state.user,
                    onSumbit: (
                      String firstName,
                      String? middleName,
                      String lastName,
                      String selectedGender,
                      DateTime birthday,
                      String? address,
                      String? profession,
                    ) {
                      BlocProvider.of<ProfileBloc>(context).add(
                        NavigateToNextPage(
                          user: state.user.copyWith(
                            firstName: firstName,
                            lastName: lastName,
                            middleName: middleName,
                            gender: selectedGender,
                            birthday: birthday,
                            address: address,
                            profession: profession,
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
            child: RegistrationContinuationForm(
              user: state.user,
              registerParameter: RegisterParameter(
                firstName: state.user.firstName,
                lastName: state.user.lastName,
                gender: state.user.gender,
                birthDay: state.user.birthday,
                address: state.user.address,
                profession: state.user.profession,
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
