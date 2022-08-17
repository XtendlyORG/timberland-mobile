// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_appbar.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
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
        return current is! ProfileUpdated;
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            handleBackButton(state, context);
            return false;
          },
          child: TimberlandScaffold(
            appBar: TimberlandAppbar(
              backButton: BackButton(
                onPressed: () {
                  handleBackButton(state, context);
                },
              ),
            ),
            titleText: 'Update Information',
            body: UpdateProfileForm(user: Session().currentUser!),
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
          return AlertDialog(
            content: const SizedBox(
              child: Text("Discard profile updates?"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx, true);
                  BlocProvider.of<ProfileBloc>(context)
                      .add(const CancelUpdateRequest());
                },
                child: const Text('Discard'),
              ),
            ],
          );
        },
      ).then(
        (value) {
          if (value) {
            Navigator.pop(context);
          }
        },
      );
    }
  }
}
