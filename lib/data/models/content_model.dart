import 'package:job_contracts/utils/constants/text_strings.dart';

class OnboardingContext {
  String image;
  String title;
  String subtitle;

  OnboardingContext({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

// Now update the contents list to use strings from the `TextStrings` class

List<OnboardingContext> contents = [
  OnboardingContext(
    image: 'assets/images/onboarding1a.png',
    title: JText.title1,
    subtitle: JText.subtitle1,
  ),
  OnboardingContext(
    image: 'assets/images/onboarding2.png',
    title: JText.title2,
    subtitle: JText.subtitle2,
  ),
  OnboardingContext(
    image: 'assets/images/onboarding3a.png',
    title: JText.title3,
    subtitle: JText.subtitle3,
  ),
];
