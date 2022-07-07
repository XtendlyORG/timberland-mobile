import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/navbar_configs.dart';
import 'package:timberland_biketrail/core/presentation/widgets/bottom_navbar.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_appbar.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/dashboard.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TimberlandScaffold(
      child: Center(
        child: Text("Qr Page"),
      ),
    );
  }
}
