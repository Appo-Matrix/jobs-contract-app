// Main Profile Screen
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar
              ProfileAppBar(isDark: isDark),

              // Profile Header with Avatar
              Align(
                  alignment: Alignment.center,
                  child: ProfileHeader(isDark: isDark)),

              // Bio Section
              ProfileSection(
                title: 'Bio',
                content: ProfileBio(isDark: isDark),
                isDark: isDark,
              ),

              // Work History Section
              ProfileSection(
                title: 'Work History',
                content: WorkHistoryList(isDark: isDark),
                isDark: isDark,
              ),

              // Education Section
              ProfileSection(
                title: 'Education',
                content: EducationList(isDark: isDark),
                isDark: isDark,
              ),

              // Skills Section
              ProfileSection(
                title: 'Skills',
                content: SkillsList(isDark: isDark),
                isDark: isDark,
              ),

              // Languages Section
              ProfileSection(
                title: 'Languages',
                content: LanguagesList(isDark: isDark),
                isDark: isDark,
              ),

              // Work History and Feedback
              ProfileSection(
                title: 'Work History and Feedback',
                content: FeedbackList(isDark: isDark),
                isDark: isDark,
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Profile App Bar Widget
class ProfileAppBar extends StatelessWidget {
  final bool isDark;

  const ProfileAppBar({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profile',
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeLg,
              weight: FontWeight.bold,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray300,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.edit)
          ),
        ],
      ),
    );
  }
}

// Profile Header Widget
class ProfileHeader extends StatelessWidget {
  final bool isDark;

  const ProfileHeader({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          // Profile Image with Red Circle Border
          Container(
            width: 96,
            height: 96,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.red,
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                JImages.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12),

          // Name
          Text(
            'Bessie Cooper',
            style: AppTextStyle.dmSans(
              fontSize: 20.0,
              weight: FontWeight.w600,

              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ),
          SizedBox(height: 8),

          // Job Title
          Text(
            'Drywall Installers Specialist',
            style: AppTextStyle.dmSans(
              fontSize: 16.0,
              weight: FontWeight.w500,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ),
          SizedBox(height: 6),

          // Earnings
          Text(
            'Earning: \$550000',
            style: AppTextStyle.dmSans(
              fontSize: 14.0,
              weight: FontWeight.w400,
              color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
            ),
          ),
        ],
      ),
    );
  }
}

// Generic Profile Section Widget
class ProfileSection extends StatelessWidget {
  final String title;
  final Widget content;
  final bool isDark;

  const ProfileSection({
    Key? key,
    required this.title,
    required this.content,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.dmSans(
              fontSize: 18.0,
              weight: FontWeight.w600,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ),
          SizedBox(height: 12),
          content,
        ],
      ),
    );
  }
}

// Bio Widget
class ProfileBio extends StatelessWidget {
  final bool isDark;

  const ProfileBio({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello, I'm Alina Abbas, a passionate Drywall Installer with 3+ years of experience in transforming construction spaces with precision and efficiency. I specialize in seamless drywall installation, finishing, and repairs, ensuring durable and aesthetically pleasing results. My expertise lies in turning complex designs into smooth, high-quality surfaces, enhancing both residential and commercial projects.",
      style: AppTextStyle.dmSans(
        fontSize: 14.0,
        height: 1.0,
        weight: FontWeight.w400,
        color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
      ),
    );
  }
}

// Work History Item Widget
class WorkHistoryItem extends StatelessWidget {
  final String period;
  final String description;
  final bool isDark;

  const WorkHistoryItem({
    Key? key,
    required this.period,
    required this.description,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          period,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.w500,
            color: JAppColors.primary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.normal,
            color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
          ),
        ),
      ],
    );
  }
}

// Work History List Widget
class WorkHistoryList extends StatelessWidget {
  final bool isDark;

  const WorkHistoryList({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WorkHistoryItem(
          period: '2002-Now',
          description: 'Self-Employed/Independent Contractors',
          isDark: isDark,
        ),
        SizedBox(height: 12),
        WorkHistoryItem(
          period: '2024-Now',
          description: 'Home Renovation & Remodeling Companies',
          isDark: isDark,
        ),
      ],
    );
  }
}

// Education List Widget
class EducationList extends StatelessWidget {
  final bool isDark;

  const EducationList({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WorkHistoryItem(
          period: '2002-Now',
          description: 'General Construction Firms',
          isDark: isDark,
        ),
      ],
    );
  }
}

// Skills List Widget
class SkillsList extends StatelessWidget {
  final bool isDark;

  const SkillsList({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final skills = [
      'mudding',
      'Sanding',
      'Acoustic',
      'Surface Repair',
      'Plaster',
      'Blueprint',
      'Ceiling',
      'Maintenance',
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills.map((skill) {
        return SkillChip(skill: skill, isDark: isDark);
      }).toList(),
    );
  }
}

// Skill Chip Widget
class SkillChip extends StatelessWidget {
  final String skill;
  final bool isDark;

  const SkillChip({
    Key? key,
    required this.skill,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        skill,
        style: AppTextStyle.dmSans(
          fontSize: JSizes.fontSizeEaSm,
          weight: FontWeight.normal,
          color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
        ),
      ),
    );
  }
}

// Languages List Widget
class LanguagesList extends StatelessWidget {
  final bool isDark;

  const LanguagesList({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languages = [
      {'language': 'Urdu', 'level': 'Basic'},
      {'language': 'English', 'level': 'Native'},
      {'language': 'Spanish', 'level': 'Fluent'},
      {'language': 'German', 'level': 'Basic'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 12,
      children: languages.map((lang) {
        return LanguageItem(
          language: lang['language']!,
          level: lang['level']!,
          isDark: isDark,
        );
      }).toList(),
    );
  }
}

// Language Item Widget
class LanguageItem extends StatelessWidget {
  final String language;
  final String level;
  final bool isDark;

  const LanguageItem({
    Key? key,
    required this.language,
    required this.level,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              language,
              style: AppTextStyle.dmSans(
                fontSize: JSizes.fontSizeEaSm,
                weight: FontWeight.normal,
                color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            level,
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeEaSm,
              weight: FontWeight.normal,
              color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
            ),
          ),
        ],
      ),
    );
  }
}

// Feedback List Widget
class FeedbackList extends StatelessWidget {
  final bool isDark;

  const FeedbackList({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FeedbackItem(
            title: 'Drywall Installers Specialist',
            description: 'id lacus, tincidunt libero, gravida ex dignissim, Vestibulum Sed faucibus in vitae',
            reviewerName: 'Caitlyn King',
            reviewerPosition: 'Head of Design, Layers',
            isDark: isDark,
          ),
          SizedBox(height: 24),
          FeedbackItem(
            title: 'Drywall Installers Specialist',
            description: 'id lacus, tincidunt libero, gravida ex dignissim, Vestibulum Sed faucibus in vitae',
            reviewerName: 'Amélie Laurent',
            reviewerPosition: 'Product Manager, Sisyphus',
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

// Feedback Item Widget
class FeedbackItem extends StatelessWidget {
  final String title;
  final String description;
  final String reviewerName;
  final String reviewerPosition;
  final bool isDark;

  const FeedbackItem({
    Key? key,
    required this.title,
    required this.description,
    required this.reviewerName,
    required this.reviewerPosition,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.bold,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
          ),
        ),
        SizedBox(height: 4),

        // 5 star rating
        Row(
          children: List.generate(
            5,
                (index) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            ),
          ),
        ),
        SizedBox(height: 8),

        Text(
          description,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeEaSm,
            weight: FontWeight.normal,
            color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
          ),
        ),
        SizedBox(height: 12),

        // Reviewer info
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/reviewer.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reviewerName,
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeSm,
                    weight: FontWeight.bold,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  ),
                ),
                Text(
                  reviewerPosition,
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeEaSm,
                    weight: FontWeight.normal,
                    color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// Now create a file to show how to use these widgets
// Example of usage in main.dart or route configuration

