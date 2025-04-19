import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:job_contracts/presentation/features/users/screen/contact_detail_screens/widgets/contact_details_widget.dart';
import 'package:job_contracts/presentation/features/users/screen/contact_detail_screens/widgets/contact_first_widget.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final List<String> skills = [
    "Easy to use",
    "Complete",
    "helpful",
    "Convenient",
    "Looks good",
  ];

  final List<String> experiences = [
    "Easy to use",
    "Complete",
    "helpful",
    "Convenient",
    "Looks good",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
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
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Your project is finished.',
                style: AppTextStyle.dmSans(
                  color:
                      isDark ? JAppColors.darkGray100 : JAppColors.lightGray1000,
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 18),
              Text(
                'How would you rate the Experience? ',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray500,
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
              _buildSection("How was Your Experience?", [
                "Could have more components",
                "Complex",
                "Not interactive",
                "Only English",
              ]),
              SizedBox(height: 26),
              _buildSection("How was Your Experience?", [
                "Could have more components",
                "Complex",
                "Not interactive",
                "Only English",
              ]),
              SizedBox(height: 26),
              Text(
                'Leave a Review?',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray700,
                  fontSize: JSizes.fontSizeMd,
                  weight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 28),
              MainButton(
                btn_title: 'Submit',
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Colors.transparent,
                title_color: Colors.white,
        
                image_value: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<String> options,
  ) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.primary : JAppColors.primary,
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((option) {
            return Chip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                // Adjust the radius
                side: BorderSide(
                    color: Colors.transparent, width: 0), // Border color
              ),
              label: Text(
                option,
                style: TextStyle(
                    fontSize: 12,
                    color: JAppColors.lightGray500,
                    fontWeight: FontWeight.w400),
              ),
              labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
              backgroundColor: JAppColors.darkGray200, // Light grey background
            );
          }).toList(),
        ),
      ],
    );
  }
}
