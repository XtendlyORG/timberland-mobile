import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<AuthBloc>(context).state as Authenticated;
    return SafeArea(
      child: TimberlandScaffold(
        titleText: 'My QR Code',
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 40),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 400,
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
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          const Spacer(),
                          AutoSizeText(
                            "${state.user.firstName} ${state.user.lastName}",
                            maxLines: 2,
                            minFontSize: 14,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Text("Manila"),
                          const Spacer(),
                          SizedBox(
                            width: 200,
                            child: QrImage(data: state.user.accessCode),
                          ),
                          const Spacer(),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const Align(
                      alignment: Alignment(0, -1.15),
                      child: CircleAvatar(
                        radius: 27,
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
