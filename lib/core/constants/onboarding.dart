// ignore_for_file: public_member_api_docs, sort_constructors_first
class OnboardingConfig {
  final String title;
  final String description;
  final String assetImagePath;
  const OnboardingConfig({
    required this.title,
    required this.description,
    required this.assetImagePath,
  });
}

abstract class OnboardingConfigs {
  static const pages = [_page1, _page2, _page3, _page4, _page5];

  static const _page1 = OnboardingConfig(
    title: 'Welcome to Timberland!',
    description: "We are here to guide you to have a seamless bike trail ride.",
    assetImagePath: 'assets/images/onboarding-1.png',
  );
  static const _page2 = OnboardingConfig(
    title: 'Browse Different Trails',
    description:
        "Timberland offers different levels of bike trails all accessible to you",
    assetImagePath: 'assets/images/onboarding-2.png',
  );
  static const _page3 = OnboardingConfig(
    title: 'Book a Day Pass',
    description: "Pick a date and take-off time and enjoy the ride!",
    assetImagePath: 'assets/images/onboarding-3.png',
  );
  static const _page4 = OnboardingConfig(
    title: 'Have a Look at our Map',
    description: "Feeling excited? Browse our map and plan your day ahead.",
    assetImagePath: 'assets/images/onboarding-4.png',
  );
  static const _page5 = OnboardingConfig(
    title: 'Emergency Services',
    description:
        "If you are in distress or think someone might need our help, please don't hesitate to use our emergency feature.",
    assetImagePath: 'assets/images/onboarding-5.png',
  );
}
