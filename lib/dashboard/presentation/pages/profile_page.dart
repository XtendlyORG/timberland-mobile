import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/profile_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProfileHeader(),
          const SizedBox(
            height: 37,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  'John SMihasadasd',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Manila',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {},
                  title: const Text(
                    'Payment History',
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                  iconColor: Theme.of(context).primaryColor,
                  textColor: TimberlandColor.text,
                ),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                  onTap: () {},
                  title: const Text(
                    'Booking History',
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                  iconColor: Theme.of(context).primaryColor,
                  textColor: TimberlandColor.text,
                ),
                const Divider(
                  thickness: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
