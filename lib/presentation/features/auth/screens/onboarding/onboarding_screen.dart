import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/onboarding/widgets/expanded_effect.dart';
import 'package:job_contracts/presentation/features/auth/screens/onboarding/widgets/smooth_page_indicator.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../theme_controller/ThemeNotifier.dart';
import 'models/onboarding_item.dart';



class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;


  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      title: 'title1',
      description: 'subtitle1',
      imagePath: JImages.image1,
    ),
    OnboardingItem(
      title: 'title2',
      description: 'subtitle2',
      imagePath: JImages.image2,
    ),
    OnboardingItem(
      title: 'title3',
      description: 'subtitle3',
      imagePath: JImages.image3,
    ),

  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Current locale: ${context.locale}");
    final locale = context.locale;
    print("Current locale: $locale");
  
    final isDark = JDeviceUtils.isDarkMode(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: themeNotifier.themeMode == ThemeMode.dark,
              onChanged: (value) => themeNotifier.toggleTheme(value),
            ),
            // Skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {

                      final currentLocale = context.locale;
                      final newLocale = currentLocale.languageCode == 'en'
                          ? const Locale('es', 'ES')
                          : const Locale('en', 'US');

                      print("Switching from $currentLocale to $newLocale");
                      await context.setLocale(newLocale);
                      setState(() {});

                      // AppRouter.router.push('/loginScreen');


                    },
                    child: Text(
                      JText.skip,
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.lightGray800,
                        fontSize: 16.0,
                        weight: FontWeight.w400,
                        height: 1.2,

                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Main illustration
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingItems.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Image.asset(
                      _onboardingItems[index].imagePath,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            // Smoother page indicator
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _onboardingItems.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: JAppColors.primary,
                  dotColor: JAppColors.lightGray500,
                  dotHeight: 6,
                  dotWidth: 12,
                  expansionFactor: 2,
                  spacing: 4,
                ),
              ),
            ),
            // Content area with light background
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color:isDark ? JAppColors.backGroundDarkCard : JAppColors.darkGray100,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    _onboardingItems[_currentPage].title,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                      fontSize: 30.0,
                      weight: FontWeight.w600,
                      height: 1.2,

                    ),

                  ).tr(),
                  SizedBox(height: 16),
                  Text(
                    _onboardingItems[_currentPage].description,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                      fontSize: 16.0,
                      weight: FontWeight.w400,
                      height: 1.2,

                    ),
                  ).tr(),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: _currentPage > 0
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.end,
                    children: [
                      if (_currentPage > 0)
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:  isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.primary,
                              width: 2,
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color:  isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.primary,
                            ),
                            onPressed: () {
                              _pageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),


                    Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF6C39FF),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_currentPage < _onboardingItems.length - 1) {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {


                              AppRouter.router.push('/loginScreen');
                              // Navigate to main app
                              print("Onboarding complete");
                            }
                          },
                        ),
                      ),
                    ],
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




