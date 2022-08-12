import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/constants/constants.dart';
import '../../../core/presentation/widgets/profile_avatar.dart';
import '../../../core/presentation/widgets/widgets.dart';
import '../../../features/authentication/presentation/bloc/auth_bloc.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<AuthBloc>(context).state as Authenticated;
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: TimberlandScaffold(
        titleText: 'My QR Code',
        body: SizedBox(
          height: mediaQuery.size.longestSide - kToolbarHeight * 4,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 40),
              child: SizedBox(
                height: 400,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 400,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(.05),
                            Colors.white.withOpacity(.04),
                            Colors.white.withOpacity(.8)
                          ],
                          stops: const [.6, .8, 1],
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: kVerticalPadding * 2,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  AutoSizeText(
                                    "${state.user.firstName} ${state.user.lastName}",
                                    maxLines: 2,
                                    minFontSize: 14,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text('63${state.user.mobileNumber}'),
                                ],
                              ),
                            ),
                            // const Spacer(),
                            // const Spacer(),
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                width: 200,
                                child: QrImage(data: state.user.accessCode),
                              ),
                            ),
                            // const Spacer(),
                            // const Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, -1.25),
                      child: ProfileAvatar(
                        radius: 40,
                        imgUrl: state.user.profilePicUrl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
