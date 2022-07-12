import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_container.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

class FirstTimeUserPage extends StatelessWidget {
  const FirstTimeUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: TimberlandContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("First time user page"),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context)
                      .add(const FinishUserGuideEvent());
                },
                child: const Text("Finish user guide"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
