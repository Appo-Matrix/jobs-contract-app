import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/onboarding/widgets/expanded_effect.dart';
import 'package:job_contracts/presentation/features/auth/screens/onboarding/widgets/smooth_page_indicator.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';
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
      title: "Effortless Project Management",
      description: "Take control of your construction and real estate projects with intuitive tools designed for professionals",
      imagePath: "assets/images/immjasda3.png",
    ),
    OnboardingItem(
      title: "Simplify Contract & Client Deals",
      description: "Easily manage contracts, negotiations, and client communications from one central platform",
      imagePath: "assets/images/onboarding2.png",
    ),
    OnboardingItem(
      title: "Maximize Your Business Opportunities",
      description: "Discover exclusive promotions, connect with industry leaders, and grow your business seamlessly",
      imagePath: "assets/images/onboarding3a.png",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            // Skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      AppRouter.router.push('/loginScreen');


                    },
                    child: Text(
                      JText.skip,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
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
                  activeDotColor: Color(0xFF6C39FF),
                  dotColor: Color(0xFFD8C5FF),
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
                color:isDark ? JAppColors.darkGray700 : JAppColors.darkGray100,
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
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    _onboardingItems[_currentPage].description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
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




