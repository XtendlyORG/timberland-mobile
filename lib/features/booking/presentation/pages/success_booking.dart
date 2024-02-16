import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

import '../widgets/checkout_information.dart';

class SuccessBookingPage extends StatelessWidget {
  const SuccessBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final user = (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;
        


    return CheckoutInformationWidget(
      icon: const Icon(Icons.check_circle_rounded, size: 64, color: Colors.green),
      title: AutoSizeText(
        'Payment Successful!',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.green,
            ),
        maxLines: 1,
      ),
      subtitle:  AutoSizeText(
        "Thank you, ${user.firstName} ${user.lastName}. See you at Timberland Mountain Bike Park",
        textAlign: TextAlign.center,
      ),
    );
  }
}
