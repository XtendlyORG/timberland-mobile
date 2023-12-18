// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
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
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        } else {
          MoveToBackground.moveTaskToBack();
        }

        return false;
      },
      child: DecoratedSafeArea(
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
                      styleTitle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TimberlandColor.primary),
                      description: OnboardingConfigs.pages[index].description,
                      styleDescription: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.normal),
                      subtitle: OnboardingConfigs.pages[index].subtitle,
                      styleSubtitle: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.normal, color: TimberlandColor.primary),
                      centerWidget: Image.asset(
                        OnboardingConfigs.pages[index].assetImagePath,
                        height: 300,
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
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
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: const Text('SKIP'),
                          ),
                        const Spacer(),
                        currentIndex == OnboardingConfigs.pages.length - 1
                            ? TextButton(
                                onPressed: () {
                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                    return;
                                  }
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
                                    duration: const Duration(milliseconds: 500),
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
    required this.subtitle,
    required this.styleSubtitle,
    required this.centerWidget,
  }) : super(key: key);
  final String title;
  final TextStyle? styleTitle;
  final String description;
  final TextStyle? styleDescription;
  final String subtitle;
  final TextStyle? styleSubtitle;

  final Widget centerWidget;

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: SizedBox(
        height: mediaquery.size.longestSide - kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              AutoSizeText(
                description,
                style: styleDescription,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              AutoSizeText(
                subtitle,
                style: styleSubtitle,
                textAlign: TextAlign.center,
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
