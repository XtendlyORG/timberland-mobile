// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/dashboard/domain/params/update_user_detail.dart';
import 'package:timberland_biketrail/dashboard/presentation/bloc/profile_bloc.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/discard_update_dialog.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/update_profile_form.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

class UpdateProfilePage extends StatelessWidget {
  final User user;
  const UpdateProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) {
        return current is UpdatingUserDetail;
      },
      builder: (context, state) {
        if (state is! ProfileInitial && state is! UpdatingUserDetail) {
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
        return WillPopScope(
          onWillPop: () async {
            handleBackButton(state, context);
            return false;
          },
          child: DecoratedSafeArea(
            child: TimberlandScaffold(
              index: 3,
              showNavbar: false,
              extendBodyBehindAppbar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    handleBackButton(state, context);
                  },
                ),
              ),
              titleText: 'Update Information',
              body: Column(
                children: [
                  UpdateProfileForm(user: Session().currentUser!),
                  const SizedBox(height: kVerticalPadding),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void handleBackButton(ProfileState state, BuildContext context) {
    if (state is UpdatingUserDetail && state.pageNum == 2) {
      BlocProvider.of<ProfileBloc>(context)
          .add(UpdateUserDetailEvent(user: state.updatedUser));
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return const DiscardUpdatesDialog(
            promptMessage: 'Discard profile updates?',
          );
        },
      ).then(
        (value) {
          if (value is bool && value) {
            Navigator.pop(context);
          }
        },
      );
    }
  }
}
