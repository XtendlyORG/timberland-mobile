// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/presentation/widgets/profile_avatar.dart';
import 'package:timberland_biketrail/dashboard/presentation/cubit/profile_header_cubit.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

import '../../../core/themes/timberland_color.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 227,
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
                color: TimberlandColor.subtext),
            child: BlocBuilder<ProfileHeaderCubit, ProfileHeaderState>(
              builder: (context, state) {
                if (state is! ProfileHeadersLoaded) {
                  return CachedNetworkImage(
                    imageUrl:
                        'https://imaging.nikon.com/lineup/dslr/df/img/sample/img_01.jpg',
                    fit: BoxFit.fitWidth,
                  );
                } else {
                  return DynamicProfileHeaders(
                    profileHeaders: state.profileHeaders,
                  );
                }
              },
            ),
          ),
          Align(
            alignment: const Alignment(-.85, 1),
            child: ProfileAvatar(
              imgUrl: user.profilePicUrl,
              radius: 27,
            ),
          ),
        ],
      ),
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
