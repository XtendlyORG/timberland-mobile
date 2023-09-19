import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

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
    return DecoratedSafeArea(
      child: TimberlandScaffold(
        titleText: 'My QR Code',
        index: 3,
        extendBodyBehindAppbar: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kHorizontalPadding / 2,
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: TimberlandColor.linearGradient,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 40 + kVerticalPadding,
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
                          padding: const EdgeInsets.symmetric(
                            vertical: kHorizontalPadding,
                          ),
                          child: QrImage(
                            data: state.user.accessCode,
                            size: 200,
                            foregroundColor: TimberlandColor.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ProfileAvatar(
                radius: 40,
                imgUrl: state.user.profilePicUrl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
