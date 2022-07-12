import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_container.dart';

class FirstTimeUserPage extends StatelessWidget {
  const FirstTimeUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TimberlandContainer(
      child: Center(
        child: Text("First time user page"),
      ),
    );
  }
}
