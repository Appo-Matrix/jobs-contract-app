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
  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.feedback,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: Padding(
          padding: const EdgeInsets.all(3.0),
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
              JText.projectFinishText,
              style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray1000,
                fontSize: JSizes.fontSizeLg,
                weight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 18),
            Text(
              JText.rateExperienceText,
              style: AppTextStyle.dmSans(
                color:
                isDark ? JAppColors.darkGray100 : JAppColors.darkGray500,
                fontSize: JSizes.fontSizeSm,
                weight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 18),
            RatingBar.builder(
              initialRating: 4,
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
                print(rating);
              },
            ),
            SizedBox(height: 20),
            FeedbackSection(title: JText.wasYourExper, options: JText.feedbackTags),
            SizedBox(height: 26),
            FeedbackSection(title: JText.youLike, options: JText.skillTags),
            SizedBox(height: 26),
            Text(
            JText.leaveAReview,
              style: AppTextStyle.dmSans(
                color:
                isDark ? JAppColors.darkGray100 : JAppColors.darkGray700,
                fontSize: JSizes.fontSizeMd,
                weight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 28),
            MainButton(
              btn_title: JText.submit,
              btn_radius: 10,
              btn_color: JAppColors.main,
              btn_boarder_color: Colors.transparent,
              title_color: Colors.white,
              image_value: false,
            ),
          ],
        ),
      ),
    );
  }
}
