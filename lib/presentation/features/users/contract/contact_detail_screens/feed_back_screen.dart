// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:job_contracts/utils/constants/colors.dart';
// import 'package:job_contracts/utils/constants/sizes.dart';
// import 'package:job_contracts/utils/constants/text_strings.dart';
// import '../../../../../utils/common_widgets/appbar.dart';
// import '../../../../../utils/common_widgets/back_circle.dart';
// import '../../../../../utils/common_widgets/main_button.dart';
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/device/device_utility.dart';
// import '../widgets/feedback_section.dart';
//
// class FeedBackScreen extends StatefulWidget {
//   const FeedBackScreen({super.key});
//
//   @override
//   State<FeedBackScreen> createState() => _FeedBackScreenState();
// }
//
// class _FeedBackScreenState extends State<FeedBackScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
//       appBar: JAppbar(
//         title: Text(
//           'feedback',
//           style: AppTextStyle.dmSans(
//             color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             fontSize: JSizes.fontSizeLg,
//             weight: FontWeight.w600,
//           ),
//         ).tr(),
//         leadingIcon: Padding(
//           padding: const EdgeInsets.all(2.0),
//           child: BackCircle(
//             isDark: isDark,
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'projectFinishText',
//               style: AppTextStyle.dmSans(
//                 color: isDark
//                     ? JAppColors.darkGray100
//                     : JAppColors.lightGray1000,
//                 fontSize: JSizes.fontSizeLg,
//                 weight: FontWeight.w500,
//               ),
//             ).tr(),
//             SizedBox(height: 18),
//             Text(
//               'rateExperienceText',
//               style: AppTextStyle.dmSans(
//                 color:
//                 isDark ? JAppColors.darkGray100 : JAppColors.darkGray500,
//                 fontSize: JSizes.fontSizeSm,
//                 weight: FontWeight.w400,
//               ),
//             ).tr(),
//             SizedBox(height: 18),
//             RatingBar.builder(
//               initialRating: 4,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemSize: 30,
//               itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
//               itemBuilder: (context, _) => Icon(
//                 Icons.star,
//                 color: Colors.amber,
//               ),
//               onRatingUpdate: (rating) {
//                 print(rating);
//               },
//             ),
//             SizedBox(height: 20),
//             FeedbackSection(title: 'wasYourExper', options: JText.feedbackTags),
//             SizedBox(height: 26),
//             FeedbackSection(title: JText.youLike, options: JText.skillTags),
//             SizedBox(height: 26),
//             Text(
//             'leaveAReview',
//               style: AppTextStyle.dmSans(
//                 color:
//                 isDark ? JAppColors.darkGray100 : JAppColors.darkGray700,
//                 fontSize: JSizes.fontSizeMd,
//                 weight: FontWeight.w600,
//               ),
//             ).tr(),
//             SizedBox(height: 10),
//             Container(
//               width: double.infinity,
//               height: 200,
//               decoration: BoxDecoration(
//                 color: isDark ? JAppColors.backGroundDarkCard.withValues(alpha: 0.4) : Colors.transparent,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray400,
//                   width: 1,
//                 ),
//               ),
//               child: TextField(
//                 maxLines: 10,
//                 style: AppTextStyle.dmSans(
//                   color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray700,
//                   fontSize: JSizes.fontSizeSm, weight: FontWeight.w400,
//                 ),
//                 decoration: InputDecoration(
//                   hintText: 'whatYouWantToTalk'.tr(),
//                   hintStyle: AppTextStyle.dmSans(
//                     color: isDark ? JAppColors.darkGray400 : JAppColors.lightGray600,
//                     fontSize: JSizes.fontSizeSm, weight: FontWeight.w400,
//                   ),
//                   contentPadding: EdgeInsets.all(16),
//                   border: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 28),
//             MainButton(
//               btn_title: 'submit',
//               btn_radius: 10,
//               btn_color: JAppColors.main,
//               btn_boarder_color: Colors.transparent,
//               title_color: Colors.white,
//               image_value: false,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';
import '../widgets/feedback_section.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  // State variables to store form data
  double _rating = 4.0;
  String? _selectedExperience;
  String? _selectedSkill;
  final TextEditingController _reviewController = TextEditingController();

  // Method to validate and submit feedback
  void _submitFeedback() {
    // Validate that at least some data is provided
    if (_rating == 0 && _selectedExperience == null &&
        _selectedSkill == null && _reviewController.text.trim().isEmpty) {
      _showErrorSnackBar('Please provide some feedback before submitting');
      return;
    }

    // Collect all feedback data
    final feedbackData = {
      'rating': _rating,
      'experience': _selectedExperience,
      'skill': _selectedSkill,
      'review': _reviewController.text.trim(),
    };

    // Print the data for debugging (you can replace this with actual API call)
    print('Feedback submitted: $feedbackData');

    // Show success message
    _showSuccessSnackBar('Thank you for your feedback!');

    // Optional: Navigate back or to a confirmation screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  // Helper method to show error message
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Helper method to show success message
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Handle experience selection from FeedbackSection
  void _onExperienceSelected(String? selectedOption) {
    setState(() {
      _selectedExperience = selectedOption;
    });
  }

  // Handle skills selection from FeedbackSection
  void _onSkillsSelected(String? selectedOption) {
    setState(() {
      _selectedSkill = selectedOption;
    });
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          'feedback',
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ).tr(),
        leadingIcon: Padding(
          padding: const EdgeInsets.all(2.0),
          child: BackCircle(
            isDark: isDark,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'projectFinishText',
              style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray1000,
                fontSize: JSizes.fontSizeLg,
                weight: FontWeight.w500,
              ),
            ).tr(),
            SizedBox(height: 18),
            Text(
              'rateExperienceText',
              style: AppTextStyle.dmSans(
                color:
                isDark ? JAppColors.darkGray100 : JAppColors.darkGray500,
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w400,
              ),
            ).tr(),
            SizedBox(height: 18),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30,
              itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
                print('Selected rating: $rating');
              },
            ),
            SizedBox(height: 20),
            FeedbackSection(
              title: 'wasYourExper',
              options: JText.feedbackTags,
              onSelectionChanged: _onExperienceSelected,
            ),
            SizedBox(height: 26),
            FeedbackSection(
              title: JText.youLike,
              options: JText.skillTags,
              onSelectionChanged: _onSkillsSelected,
            ),
            SizedBox(height: 26),
            Text(
              'leaveAReview',
              style: AppTextStyle.dmSans(
                color:
                isDark ? JAppColors.darkGray100 : JAppColors.darkGray700,
                fontSize: JSizes.fontSizeMd,
                weight: FontWeight.w600,
              ),
            ).tr(),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: isDark ? JAppColors.backGroundDarkCard.withValues(alpha: 0.4) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray400,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _reviewController,
                maxLines: 10,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray700,
                  fontSize: JSizes.fontSizeSm, weight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'whatYouWantToTalk'.tr(),
                  hintStyle: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray400 : JAppColors.lightGray600,
                    fontSize: JSizes.fontSizeSm, weight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 28),
            MainButton(
              btn_title: 'submit',
              btn_radius: 10,
              btn_color: JAppColors.main,
              btn_border_color: Colors.transparent,
              title_color: Colors.white,
              image_value: false,
              onTap: _submitFeedback,
            ),
          ],
        ),
      ),
    );
  }
}