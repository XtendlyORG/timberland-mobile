// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/presentation/widgets/profile_avatar.dart';
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
            child: const Image(
              image: NetworkImage(
                'https://imaging.nikon.com/lineup/dslr/df/img/sample/img_01.jpg',
              ),
              fit: BoxFit.fitWidth,
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
