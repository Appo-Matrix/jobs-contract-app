class OnboardingContext {
  String image;
  String title;

  OnboardingContext({
    required this.image,
    required this.title,
  });
}

List<OnboardingContext> contents = [
  OnboardingContext(
    image: 'assets/images/onboarding1.png',
    title: 'Simplify and Streamline Your Job Contracts with Ease',

  ),
  OnboardingContext(
    image: 'assets/images/onboarding2.png',
    title: 'Effortless Collaboration for Smooth Workflows',
    ),
  OnboardingContext(
    image: 'assets/images/onboarding3.png',
    title: 'Track, Manage, and Stay Organized Anytime',
   ),

];

