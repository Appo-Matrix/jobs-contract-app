// import 'package:flutter/material.dart';
// import 'package:job_contracts/utils/constants/image_string.dart';
// import '../../../../utils/common_widgets/appbar.dart';
// import '../../../../utils/common_widgets/back_circle.dart';
// import '../../../../utils/common_widgets/main_button.dart';
// import '../../../../utils/constants/app_text_style.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/text_strings.dart';
// import '../../../../utils/device/device_utility.dart';
// import 'ad_context_menu.dart';
//
// class AdDetailsScreen extends StatefulWidget {
//   const AdDetailsScreen({super.key});
//
//   @override
//   State<AdDetailsScreen> createState() => _AdDetailsScreenState();
// }
//
// class _AdDetailsScreenState extends State<AdDetailsScreen> {
//   int _currentImageIndex = 0;
//   final int _totalImages = 3; // Replace with actual count from your data
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
//       appBar: JAppbar(
//         title: Text(
//           JText.adDetails,
//           style: AppTextStyle.dmSans(
//             color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//             fontSize: 20.0,
//             weight: FontWeight.w600,
//           ),
//         ),
//         leadingIcon: BackCircle(
//           isDark: isDark,
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.more_vert,
//               color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
//             ),
//             onPressed: () {
//               showAdContextMenu(context);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image Gallery Section
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Stack(
//                 children: [
//                   // Main Image
//                   Container(
//                     width: double.infinity,
//                     decoration:  BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage(JImages.image),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//
//                   // Image Pagination Indicators
//                   Positioned(
//                     bottom: 16,
//                     left: 0,
//                     right: 0,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         _totalImages,
//                             (index) => Container(
//                           width: 8,
//                           height: 8,
//                           margin: const EdgeInsets.symmetric(horizontal: 4),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: _currentImageIndex == index
//                                 ? JAppColors.primary
//                                 : Colors.white.withOpacity(0.5),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Ad Content
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Ad Title
//                   Text(
//                     "Ad Title Will Be Here",
//                     style: AppTextStyle.dmSans(
//                       color: isDark ? Colors.white : Colors.black,
//                       fontSize: 20.0,
//                       weight: FontWeight.w600,
//                     ),
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   // Ad Description
//                   Text(
//                     "Ensure your account security and receive important updates by verifying your phone number. Enter the code sent to your mobile to complete the verification process quickly and easily. Ensure your account security and receive important updates by verifying your phone number. Enter the code sent to your mobile to complete the verification process quickly and easily.",
//                     style: AppTextStyle.dmSans(
//                       color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray700,
//                       fontSize: 14.0,
//                       weight: FontWeight.w400,
//                       height: 1.5,
//                     ),
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   // Price and Category Row
//                   Row(
//                     children: [
//                       // Price
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               JText.price,
//                               style: AppTextStyle.dmSans(
//                                 color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
//                                 fontSize: 14.0,
//                                 weight: FontWeight.w400,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               "\$1600",
//                               style: AppTextStyle.dmSans(
//                                 color: isDark ? Colors.white : Colors.black,
//                                 fontSize: 18.0,
//                                 weight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       // Category
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               JText.category,
//                               style: AppTextStyle.dmSans(
//                                 color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
//                                 fontSize: 14.0,
//                                 weight: FontWeight.w400,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               "Material",
//                               style: AppTextStyle.dmSans(
//                                 color: isDark ? Colors.white : Colors.black,
//                                 fontSize: 18.0,
//                                 weight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   // Map Location
//                   Text(
//                     JText.mapLocation,
//                     style: AppTextStyle.dmSans(
//                       color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//                       fontSize: 16.0,
//                       weight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//
//                   // Map Container
//                   Container(
//                     height: 200,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     clipBehavior: Clip.antiAlias,
//                     child: Image.asset(
//                       JImages.image,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//
//                   const SizedBox(height: 32),
//
//                   // Publish Button
//                   MainButton(
//                     btn_title: JText.publishAd,
//                     btn_radius: 10,
//                     btn_color: JAppColors.main,
//                     btn_boarder_color: JAppColors.primary,
//                     title_color: Colors.white,
//                     text_fontweight: FontWeight.w600,
//                     image_value: false,
//                     onTap: () {
//                       // Handle publish action
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import 'ad_context_menu.dart';

class AdDetailsScreen extends StatefulWidget {
  const AdDetailsScreen({super.key});

  @override
  State<AdDetailsScreen> createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  // Sample list of images for the carousel
  final List<String> _imagesList = [
    JImages.image,
    JImages.image,
    JImages.image,
    // Add more images as needed
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
      appBar: JAppbar(
        title: Text(
          JText.adDetails,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
            ),
            onPressed: () {
              showAdContextMenu(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhanced Image Carousel Section
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  // PageView for swiping through images
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _imagesList.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(_imagesList[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),

                  // Left navigation arrow
                  if (_imagesList.length > 1)
                    Positioned(
                      left: 8,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (_currentImageIndex > 0) {
                            _pageController.animateToPage(
                              _currentImageIndex - 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),

                  // Right navigation arrow
                  if (_imagesList.length > 1)
                    Positioned(
                      right: 8,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (_currentImageIndex < _imagesList.length - 1) {
                            _pageController.animateToPage(
                              _currentImageIndex + 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),

                  // Enhanced pagination indicators with smooth animation
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _imagesList.length,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: _currentImageIndex == index ? 16 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _currentImageIndex == index
                                ? JAppColors.primary
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Ad Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ad Title
                  Text(
                    "Ad Title Will Be Here",
                    style: AppTextStyle.dmSans(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 20.0,
                      weight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Ad Description
                  Text(
                    "Ensure your account security and receive important updates by verifying your phone number. Enter the code sent to your mobile to complete the verification process quickly and easily. Ensure your account security and receive important updates by verifying your phone number. Enter the code sent to your mobile to complete the verification process quickly and easily.",
                    style: AppTextStyle.dmSans(
                      color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray700,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Price and Category Row
                  Row(
                    children: [
                      // Price
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              JText.price,
                              style: AppTextStyle.dmSans(
                                color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
                                fontSize: 14.0,
                                weight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$1600",
                              style: AppTextStyle.dmSans(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 18.0,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Category
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              JText.category,
                              style: AppTextStyle.dmSans(
                                color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
                                fontSize: 14.0,
                                weight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Material",
                              style: AppTextStyle.dmSans(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 18.0,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Map Location
                  Text(
                    JText.mapLocation,
                    style: AppTextStyle.dmSans(
                      color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                      fontSize: 16.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Map Container
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      JImages.image,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Publish Button
                  MainButton(
                    btn_title: JText.publishAd,
                    btn_radius: 10,
                    btn_color: JAppColors.main,
                    btn_boarder_color: JAppColors.primary,
                    title_color: Colors.white,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                    onTap: () {
                      // Handle publish action
                    },
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