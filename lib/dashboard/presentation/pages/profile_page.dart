import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';

import '../../../core/router/router.dart';
import '../../../core/themes/timberland_color.dart';
import '../../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../widgets/profile_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => current is Authenticated,
      builder: (context, state) {
        final authState = (state as Authenticated);
        return RefreshableScrollView(
          onRefresh: () async {
            log('refresh profile');
          },
          child: Column(
            children: [
              ProfileHeader(
                user: authState.user,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "${authState.user.firstName} ${authState.user.lastName}",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '63${authState.user.mobileNumber}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      onTap: () {
                        context.pushNamed(Routes.qr.name);
                      },
                      title: const Text(
                        'My QR Code',
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
                      onTap: () {
                        context.pushNamed(Routes.paymentHistory.name);
                      },
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
                      onTap: () {
                        context.pushNamed(Routes.bookingHistory.name);
                      },
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
      },
    );
  }
}
