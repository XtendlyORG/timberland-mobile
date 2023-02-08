// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/notifications/domain/entities/announcement.dart';

class AnnouncementDialog extends StatelessWidget {
  const AnnouncementDialog({
    Key? key,
    required this.announcement,
    required this.controller,
  }) : super(key: key);
  final Announcement announcement;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: kVerticalPadding,
        bottom: kToolbarHeight / 4,
        left: kVerticalPadding,
        right: kVerticalPadding,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: kVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: TimberlandColor.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 5,
              offset: Offset(1, 1))
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              controller.reverse();
            },
            child: const Align(
              alignment: Alignment.topRight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: TimberlandColor.primary,
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: TimberlandColor.background,
                  ),
                ),
              ),
            ),
          ),
          Image.asset(
            'assets/icons/announcement-icon.png',
            height: 128,
            width: 120,
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          Text(
            announcement.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: TimberlandColor.primary),
            textAlign: TextAlign.center,
          ),
          Text(
            announcement.title,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
        ],
      ),
    );
  }
}
