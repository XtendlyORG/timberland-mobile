// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timberland_biketrail/core/presentation/widgets/profile_avatar.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/dashboard/domain/params/update_user_detail.dart';
import 'package:timberland_biketrail/dashboard/presentation/bloc/profile_bloc.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

import '../../../core/presentation/widgets/state_indicators/state_indicators.dart';
import '../../../features/authentication/presentation/bloc/auth_bloc.dart';

class ProfileHeader extends StatefulWidget {
  ProfileHeader({Key? key, required this.user}) : super(key: key);

  User user;

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateError) {
          showError(state.errorMessage);
        }
        if (state is ProfileUpdated) {
          Session().updateUser(state.user);
          context.read<AuthBloc>().add(const FetchUserEvent());
          showSuccess("Avatar updated");

          log('session img: ${Session().currentUser?.profilePicUrl}');
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 104,
          child: Align(
            alignment: const Alignment(-.85, 1),
            child: InkWell(
              onTap: () async {
                XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  showLoading("Updating Avatar");

                  context.read<ProfileBloc>().add(
                        SubmitUpdateUserDetailRequestEvent(
                          updateProfileParams: UpdateUserDetailsParams(
                            firstName: widget.user.firstName,
                            middleName: widget.user.middleName,
                            lastName: widget.user.lastName,
                            mobileNumber: widget.user.mobileNumber,
                            emergencyContactInfo: widget.user.emergencyContactInfo,
                            address: widget.user.address,
                            gender: widget.user.gender,
                            birthday: widget.user.birthday,
                            bloodType: widget.user.bloodType,
                            profession: widget.user.profession,
                            bikeColor: widget.user.bikeColor,
                            bikeModel: widget.user.bikeModel,
                            bikeYear: widget.user.bikeYear,
                            profilePic: File(image.path),
                          ),
                        ),
                      );
                }
              },
              child: ProfileAvatar(
                imgUrl: widget.user.profilePicUrl,
                radius: 27,
              ),
            ),
          ),
        );
      },
    );
  }
}

class DynamicProfileHeaders extends StatefulWidget {
  const DynamicProfileHeaders({
    Key? key,
    required this.profileHeaders,
  }) : super(key: key);
  final List<String> profileHeaders;

  @override
  State<DynamicProfileHeaders> createState() => _DynamicProfileHeadersState();
}

class _DynamicProfileHeadersState extends State<DynamicProfileHeaders> {
  int index = 0;
  late final Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        setState(() {
          index = (index + 1) % widget.profileHeaders.length;
        });
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: CachedNetworkImage(
        key: ValueKey(widget.profileHeaders[index].hashCode),
        imageUrl: widget.profileHeaders[index],
        fit: BoxFit.fitWidth,
        width: double.infinity,
      ),
    );
  }
}
