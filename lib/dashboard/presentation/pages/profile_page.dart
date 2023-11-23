
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/dashboard/presentation/cubit/profile_header_cubit.dart';

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
            BlocProvider.of<ProfileHeaderCubit>(context).fetchProfileHeaders();
          },
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                decoration: const BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  children: [
                    ProfileHeader(
                      user: authState.user,
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),
                        gradient: TimberlandColor.linearGradient,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          AutoSizeText(
                            "${state.user.firstName} ${state.user.lastName}",
                            maxLines: 2,
                            minFontSize: 14,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: kVerticalPadding / 2,
                          ),
                          Text(
                            state.user.prettierID,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0,24,0,8
                            ),
                            child: QrImage(
                              data: state.user.accessCode,
                              size: MediaQuery.of(context).size.width * .7,
                              foregroundColor: TimberlandColor.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    // AutoSizeText(
                    //   "${authState.user.firstName} ${authState.user.lastName}",
                    //   maxLines: 1,
                    //   style: Theme.of(context).textTheme.titleLarge,
                    // ),
                    // Text(
                    //   '63${authState.user.mobileNumber}',
                    //   style: Theme.of(context).textTheme.titleMedium,
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // ListTile(
                    //   onTap: () {
                    //     context.pushNamed(Routes.qr.name);
                    //   },
                    //   title: const Text(
                    //     'My QR Code',
                    //   ),
                    //   trailing: const Icon(
                    //     Icons.arrow_forward_ios_rounded,
                    //   ),
                    //   iconColor: Theme.of(context).primaryColor,
                    //   textColor: TimberlandColor.text,
                    // ),
                    // const Divider(
                    //   thickness: 2,
                    // ),
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
