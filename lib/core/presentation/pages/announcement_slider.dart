// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
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

class AnnouncementSlider extends StatefulWidget {
  const AnnouncementSlider({Key? key}) : super(key: key);

  @override
  State<AnnouncementSlider> createState() => _AnnouncementSliderState();
}

class _AnnouncementSliderState extends State<AnnouncementSlider> {
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
                    return AnnouncementSlide(
                      title: OnboardingConfigs.pages[index].title,
                      description: OnboardingConfigs.pages[index].description,
                      imagePath: "N/A",
                      cancelTimer:() {
                        //
                      },
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

class AnnouncementSlide extends StatelessWidget {
  const AnnouncementSlide({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.cancelTimer,
  }) : super(key: key);
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback cancelTimer;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        cancelTimer();
        context.pushNamed(Routes.announcementsList.name);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          border: Border.all(
            color: Colors.white.withOpacity(0.50),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/icons/launcher-icon.png'),
                        fit: BoxFit.cover
                      )
                    ),
                    // child: const Center(child: CircularProgressIndicator.adaptive())
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.25),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imagePath),
                        fit: BoxFit.cover
                      )
                    ),
                    // child: Image.asset(
                    //   'assets/splash/splash_background.png',
                    //   colorBlendMode: BlendMode.darken,
                    //   color: Colors.black.withOpacity(.3),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: AutoSizeText(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: size.height > 700
                    ? null
                    : 14
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: AutoSizeText(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontSize: size.height > 700
                    ? 16
                    : 13
                ),
                textAlign: TextAlign.center,
                maxLines: 5,
                // overflow: TextOverflow.ellipsis,
                overflowReplacement: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: description.length < 125
                        ? description
                        : description.substring(0, 125),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white, fontSize: 14),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            //
                          },
                        text: " ... Read more",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white, // TimberlandColor.primary,
                          fontSize: size.height > 700
                            ? 16
                            : 13,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                // Text(
                //   "${description.length < 125
                //       ? description
                //       : description.substring(0, 125)
                //   } ... Read More",
                //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                //     color: Colors.white,
                //     fontSize: 14
                //   ),
                //   textAlign: TextAlign.center,
                // ),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
