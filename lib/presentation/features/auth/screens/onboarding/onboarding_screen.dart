import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../data/models/content_model.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/widget_support.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      // Apply background color based on theme
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      body: PageView.builder(
          controller: _controller,
          itemCount: contents.length,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (_, i) {
            return Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 35),
                        if (currentIndex == 0)
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  textAlign: TextAlign.end,
                                  JText.skip,
                                  style: AppTextStyle.dmSans(
                                      color: isDark
                                          ? JAppColors.darkGray100
                                          : JAppColors.lightGray800,
                                      fontSize: 14.0,
                                      weight: FontWeight.w500),
                                )),
                          ),
                        SizedBox(height: 10),
                        const SizedBox(height: 16),
                        Image.asset(
                          contents[i].image,
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 1.9,
                          fit: BoxFit.fill,
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                            (index) => buildDot(index, context, isDark),
                          ),
                        ),
                        const SizedBox(height: 3),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        // Apply bottom container color based on theme
                        color: isDark
                            ? JAppColors.darkGray700
                            : JAppColors.lightGray100,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 24),
                        child: Column(
                          children: [
                            Text(
                              contents[i].title,
                              style: isDark
                                  ? AppWidget.semiBoldTextFieldStyle()
                                      .copyWith(color: JAppColors.darkGray100)
                                  : AppWidget.semiBoldTextFieldStyle(),
                            ),
                            Spacer(),
                            if (currentIndex == 0)
                              ForwardButton(
                                isDark: isDark,
                                onClick: () {
                                  _controller.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                                },
                              ),
                            if (currentIndex == 0) SizedBox(height: 40),
                            if (currentIndex == 1)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BackButton(
                                      isDark: isDark,
                                      onClick: () {
                                        _controller.previousPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn);
                                      }),
                                  SizedBox(width: 7),
                                  ForwardButton(
                                    isDark: isDark,
                                    onClick: () {
                                      _controller.nextPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeIn);
                                    },
                                  ),
                                ],
                              ),
                            if (currentIndex == 1) SizedBox(height: 40),
                            if (currentIndex == 2)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign Up As',
                                    style: AppTextStyle.dmSans(
                                        color: isDark
                                            ? JAppColors.darkGray100
                                            : JAppColors.lightGray800,
                                        fontSize: 16.0,
                                        weight: FontWeight.w600),
                                  ),
                                  SizedBox(height: JSizes.spaceBtwItems),
                                  MainButton(
                                    btn_title:
                                        "I'm a client, Hiring Professionals ",
                                    btn_radius: 10,
                                    btn_color: JAppColors.primary,
                                    btn_boarder_color: Color(0xff7030F1),
                                    title_color: isDark
                                        ? JAppColors.lightGray100
                                        : JAppColors.lightGray100,
                                    image_value: false,
                                  ),
                                  SizedBox(height: 10),
                                  MainButton(
                                    onTap: () {

                                      AppRouter.router.push('/loginScreen');

                                    },
                                    btn_title:
                                        "I'm a Freelancer, Looking for work",
                                    btn_radius: 10,
                                    btn_color: Colors.transparent,
                                    btn_boarder_color: isDark
                                        ? JAppColors.lightGray100
                                        : JAppColors.primary,
                                    title_color: isDark
                                        ? JAppColors.lightGray100
                                        : JAppColors.primary,
                                    image_value: false,

                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: isDark
                                                ? JAppColors.darkGray300
                                                : Color(0xff667085),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        ' Log in',
                                        style: AppTextStyle.dmSans(
                                            color: isDark
                                                ? JAppColors.darkGray100
                                                : JAppColors.primary,
                                            fontSize: 14.0,
                                            weight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  // Updated to include dark mode for dots
  Container buildDot(int index, BuildContext context, bool isDark) {
    return Container(
      height: 3,
      width: 40,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: currentIndex == index
            ? (isDark ? JAppColors.primary : JAppColors.primary)
            : (isDark ? JAppColors.lightGray100 : JAppColors.darkGray500),
      ),
    );
  }
}

// Updated BackButton with dark mode support
class BackButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback? onClick;

  const BackButton({
    super.key,
    required this.isDark,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.all(
              color: isDark ? JAppColors.lightGray100 : JAppColors.primary,
              width: 1),
          // Optional: Add a slight background in dark mode for better visibility
          color: isDark ? Colors.transparent : Colors.transparent,
        ),
        child: Icon(
          Icons.arrow_back,
          color: isDark ? JAppColors.lightGray100 : JAppColors.primary,
        ),
      ),
    );
  }
}

// Updated ForwardButton with dark mode support
class ForwardButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onClick;

  const ForwardButton({
    super.key,
    required this.isDark,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: Color(0xff7030F1),
          // Optional: Add a slight shadow in light mode
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
        ),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}
