import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              color: Colors.amber,
            ),
            child: const Image(
              image: NetworkImage(
                'https://imaging.nikon.com/lineup/dslr/df/img/sample/img_01.jpg',
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          const Align(
            alignment: Alignment(-.85, 1.35),
            child: CircleAvatar(
              radius: 27,
            ),
          ),
        ],
      ),
    );
  }
}
