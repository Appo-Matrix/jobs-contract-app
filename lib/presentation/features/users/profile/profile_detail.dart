import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/education_list.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/feedback_list.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/languages_list.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/profile_bio.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/profile_header.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/profile_section.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/skills_list.dart';
import 'package:job_contracts/presentation/features/users/profile/widgets/work_history_list.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/appbar.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../account_screen/bottomsheet/showEducationBottomSheet.dart';
import '../account_screen/bottomsheet/showSkillsBottomSheet.dart';
import '../account_screen/bottomsheet/showWorkExperienceBottomSheet.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          textAlign: TextAlign.start,
          'profile',
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.bold,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
          ),
        ).tr(),

          leadingIcon: const Icon(Icons.arrow_back),
          leadingOnPressed: () => Navigator.pop(context),
      ),
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
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

                title: 'bio',
                content: ProfileBio(isDark: isDark),
                isDark: isDark,
                voidCallback: () {},
              ),

              // Work History Section
              ProfileSection(
                iconPath: JImages.edit_iconSvg,

                title: 'workHistory',
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

                title: 'education',
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

                title: 'skills',
                content: SkillsList(isDark: isDark),
                isDark: isDark,
                voidCallback: () {
                  showSkillsBottomSheet(context, isDark);
                },
              ),

              // Languages Section
              ProfileSection(
                iconPath: JImages.edit_iconSvg,

                title: 'languages',
                content: LanguagesList(isDark: isDark),
                isDark: isDark,
                voidCallback: (){
                  AppRouter.router.push('/languageScreen');

                },
              ),

              // Work History and Feedback
              ProfileSection(
                iconPath: "",
                title: 'workFeedback',
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
