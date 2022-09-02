// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/constants/onboarding.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

class OnboardingSlider extends StatefulWidget {
  const OnboardingSlider({Key? key}) : super(key: key);

  @override
  State<OnboardingSlider> createState() => _OnboardingSliderState();
}

class _OnboardingSliderState extends State<OnboardingSlider> {
  late final PageController controller;
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    controller = PageController();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex > 0) {
          currentIndex--;

          controller.animateToPage(
            currentIndex,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }

        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: TimberlandContainer(
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemCount: OnboardingConfigs.pages.length,
                  itemBuilder: (context, index) {
                    return OnbaordingSlide(
                      title: OnboardingConfigs.pages[index].title,
                      styleTitle: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: TimberlandColor.primary),
                      description: OnboardingConfigs.pages[index].description,
                      styleDescription: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.normal),
                      centerWidget: Image.asset(
                        OnboardingConfigs.pages[index].assetImagePath,
                        height: 350,
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: kToolbarHeight,
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: OnboardingConfigs.pages.length,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: TimberlandColor.primary,
                      ),
                      onDotClicked: (index) {
                        currentIndex = index;
                        controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kVerticalPadding,
                    ),
                    height: kToolbarHeight,
                    child: Row(
                      children: [
                        if (currentIndex != OnboardingConfigs.pages.length - 1)
                          TextButton(
                            onPressed: () {
                              currentIndex = OnboardingConfigs.pages.length - 1;

                              controller.animateToPage(
                                currentIndex,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: const Text('SKIP'),
                          ),
                        const Spacer(),
                        currentIndex == OnboardingConfigs.pages.length - 1
                            ? TextButton(
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    const FinishUserGuideEvent(),
                                  );
                                  context.goNamed(Routes.booking.name);
                                },
                                child: const Text('DONE'),
                              )
                            : TextButton(
                                onPressed: () {
                                  currentIndex++;

                                  controller.animateToPage(
                                    currentIndex,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                child: const Text('NEXT'),
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnbaordingSlide extends StatelessWidget {
  const OnbaordingSlide({
    Key? key,
    required this.title,
    required this.styleTitle,
    required this.description,
    required this.styleDescription,
    required this.centerWidget,
  }) : super(key: key);
  final String title;
  final TextStyle? styleTitle;
  final String description;
  final TextStyle? styleDescription;
  final Widget centerWidget;

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: SizedBox(
        height: mediaquery.size.longestSide - kToolbarHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight, bottom: 10),
                child: AutoSizeText(
                  title,
                  style: styleTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            centerWidget,
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: AutoSizeText(
                description,
                style: styleDescription,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
