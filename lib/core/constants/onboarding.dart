// ignore_for_file: public_member_api_docs, sort_constructors_first
class OnboardingConfig {
  final String title;
  final String description;
  final String subtitle;
  final String assetImagePath;
  const OnboardingConfig({
    required this.title,
    required this.description,
    required this.subtitle,
    required this.assetImagePath,
  });
}

abstract class OnboardingConfigs {
  static const pages = [_page1, _page2, _page3, _page4, _page5];

  static const _page1 = OnboardingConfig(
    title: 'Welcome to Timberland Mountain Bike Park',
    description: "This app is like having the Park In Your Pocket.\nTap Next to learn more about TMBP and the app.",
    subtitle: '',
    assetImagePath: 'assets/images/onboarding-1.png',
  );
  static const _page2 = OnboardingConfig(
    title: 'We’ve got trails!',
    description: "TMBP’s trail system has something for every rider, from Novice to Expert and everything in between.",
    subtitle: 'More information can be found in the Trail Directory.',
    assetImagePath: 'assets/images/onboarding-2.png',
  );
  static const _page3 = OnboardingConfig(
    title: 'Where To Start?',
    description: "Check out the Trail Map and see what TMBP has to offer. We recommend that all riders visit the Skills Zone first to warm up.",
    subtitle: 'You can download the map by pressing and holding it',
    assetImagePath: 'assets/images/onboarding-3.png',
  );
  static const _page4 = OnboardingConfig(
    title: 'Ready To Ride?',
    description:
        "Booking a day pass is easy. Choose a date and your expected takeoff time, fill up any other necessary info and pay. Booking cutoff is 48H before your ride date. A unique QR code will be generated for every rider - please present this for scanning upon arrival at the Park Offce.",
    subtitle: 'Only riders 16 years old and above are allowed in TMBP at this time.',
    assetImagePath: 'assets/images/onboarding-4.png',
  );
  static const _page5 = OnboardingConfig(
    title: 'Just In Case...',
    description: "This app also features an emergency call button. If you or another rider is need of help, press this button to contact Park Staff.",
    subtitle: 'Make sure you read The Mountain Biker\'s Responsibility Code.',
    assetImagePath: 'assets/images/onboarding-5.png',
  );
}
