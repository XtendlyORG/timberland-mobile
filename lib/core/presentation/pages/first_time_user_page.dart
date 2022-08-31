// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:timberland_biketrail/core/constants/onboarding.dart';
// import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

class FirstTimeUserPage extends StatelessWidget {
  const FirstTimeUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TimberlandContainer(
          child: IntroSlider(
            hideStatusBar: true,
            colorActiveDot: TimberlandColor.primary,
            colorDot: TimberlandColor.primary,
            typeDotAnimation: DotSliderAnimation.SIZE_TRANSITION,
            onDonePress: () {
              BlocProvider.of<AuthBloc>(context)
                  .add(const FinishUserGuideEvent());
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            },
            slides: OnboardingConfigs.pages
                .map(
                  (page) => Slide(
                    title: page.title,
                    styleTitle: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: TimberlandColor.primary),
                    description: page.description,
                    styleDescription: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.normal),
                    centerWidget: Image.asset(
                      page.assetImagePath,
                      height: 350,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
