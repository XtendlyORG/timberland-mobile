import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';

import '../../constants/constants.dart';
import '../../router/router.dart';
import '../../themes/timberland_color.dart';
import '../widgets/filled_text_button.dart';
import '../widgets/timberland_container.dart';

class RouteNotFoundPage extends StatelessWidget {
  final String location;
  const RouteNotFoundPage({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedSafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              context.goNamed(Routes.trails.name);
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: TimberlandContainer(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(kHorizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Icon(
                    Icons.error_outline_rounded,
                    color: TimberlandColor.primary,
                    size: 128,
                  ),
                  AutoSizeText(
                    "Page Not Found",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: TimberlandColor.primary,
                        ),
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    'route: $location',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: TimberlandColor.lightBlue,
                        ),
                    maxLines: 1,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: FilledTextButton(
                      onPressed: () {
                        context.goNamed(Routes.trails.name);
                      },
                      child: const Text('Go back to Home'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
