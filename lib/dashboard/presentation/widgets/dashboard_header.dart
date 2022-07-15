import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

class DashBoardHeader extends StatelessWidget {
  const DashBoardHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<AuthBloc>(context).state as Authenticated;
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 35,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "${state.user.firstName} ${state.user.lastName}",
                    minFontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).backgroundColor,
                        ),
                  ),
                  Text(
                    'Manila',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).backgroundColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
