// Main Profile Screen
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/education_list.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/feedback_list.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/languages_list.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/profile_bio.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/profile_header.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/profile_section.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/skills_list.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/work_history_list.dart';
import 'package:job_contracts/presentation/features/users/screen/account_screen/bottomsheet/showSkillsBottomSheet.dart';
import 'package:job_contracts/presentation/features/users/screen/account_screen/bottomsheet/showWorkExperienceBottomSheet.dart';
import 'package:job_contracts/utils/common_widgets/appbar.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../screen/account_screen/bottomsheet/showEducationBottomSheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          textAlign: TextAlign.start,
          'Profile',
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.bold,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
          ),
        ),
        actions: [
          //
          // GestureDetector(
          //   onTap: (){},
          //   child: SvgPicture.asset(
          //
          //     color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
          //     Ji!,
          //     width: 20,
          //     height: 20,
          //   ),
          // )

        ],
      ),
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: ProfileHeader(isDark: isDark)),

              // Bio Section
              ProfileSection(
                iconPath: JImages.edit_iconSvg,

                title: 'Bio',
                content: ProfileBio(isDark: isDark),
                isDark: isDark,
                voidCallback: () {},
              ),

              // Work History Section
              ProfileSection(
                iconPath: JImages.edit_iconSvg,

                title: 'Work History',
                content: WorkHistoryList(isDark: isDark),
                isDark: isDark,
                voidCallback: () {
                  showWorkExperienceBottomSheet(context, isDark);
                },
              ),
              //
              // Education Section
              ProfileSection(
                iconPath: JImages.edit_iconSvg,

                title: 'Education',
                content: EducationList(isDark: isDark),
                isDark: isDark,
                voidCallback: () {
                  showEducationBottomSheet(context);
                },
              ),

              //
              // Skills Section
              ProfileSection(
                iconPath: JImages.edit_iconSvg,

                title: 'Skills',
                content: SkillsList(isDark: isDark),
                isDark: isDark,
                voidCallback: () {
                  showSkillsBottomSheet(context, isDark);
                },
              ),

              // Languages Section
              ProfileSection(
                iconPath: JImages.edit_iconSvg,

                title: 'Languages',
                content: LanguagesList(isDark: isDark),
                isDark: isDark,
              ),

              // Work History and Feedback
              ProfileSection(
                iconPath: "",
                title: 'Work History and Feedback',
                content: FeedbackList(isDark: isDark),
                isDark: isDark,
              ),
              //
              // SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
