// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_appbar.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/dashboard/presentation/bloc/profile_bloc.dart';
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
        if (current is ProfileUpdated) {
          context.goNamed(Routes.profile.name);
        }
        return current is! ProfileUpdated;
      },
      builder: (context, state) {
        return TimberlandScaffold(
          appBar: (state is UpdatingProfile && state.pageNum == 2)
              ? TimberlandAppbar(
                  backButton: BackButton(
                    onPressed: () {
                      BlocProvider.of<ProfileBloc>(context)
                          .add(UpdateProfileEvent(user: state.updatedUser));
                    },
                  ),
                )
              : null,
          titleText: 'Edit Profile',
          body: UpdateProfileForm(user: user),
        );
      },
    );
  }
}
