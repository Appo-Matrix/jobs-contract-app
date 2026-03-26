//   import 'package:easy_localization/easy_localization.dart';
//   import 'package:flutter/material.dart';
//   import 'package:job_contract_app/presentation/features/users/providers/auth_provider.dart';
//   import 'package:provider/provider.dart';
//
//   import 'package:job_contract_app/presentation/features/users/profile/widgets/education_list.dart';
//   import 'package:job_contract_app/presentation/features/users/profile/widgets/feedback_list.dart';
//   import 'package:job_contract_app/presentation/features/users/profile/widgets/languages_list.dart';
//   import 'package:job_contract_app/presentation/features/users/profile/widgets/profile_bio.dart';
//   import 'package:job_contract_app/presentation/features/users/profile/widgets/profile_header.dart';
//   import 'package:job_contract_app/presentation/features/users/profile/widgets/profile_section.dart';
//   import 'package:job_contract_app/presentation/features/users/profile/widgets/skills_list.dart';
//   import 'package:job_contract_app/presentation/features/users/profile/widgets/work_history_list.dart';
//
//   import '../../../../utils/common_widgets/ErrorState.dart';
//   import '../../../../utils/common_widgets/appbar.dart';
//   import '../../../../utils/constants/app_text_style.dart';
//   import '../../../../utils/constants/colors.dart';
//   import '../../../../utils/constants/image_string.dart';
//   import '../../../../utils/constants/sizes.dart';
//   import '../../../../utils/device/device_utility.dart';
//   import '../../../routes/app_routes.dart';
//   import '../account_screen/bottomsheet/showEducationBottomSheet.dart';
//   import '../account_screen/bottomsheet/showSkillsBottomSheet.dart';
//   import '../account_screen/bottomsheet/showWorkExperienceBottomSheet.dart';
//   import '../providers/experience_provider.dart';
//   import '../../../../data/models/auth/login_res.dart';
//   import '../providers/qualification_provider.dart';
//   import '../providers/skill_provider.dart';
// import 'EditAllProfileScreen.dart';
//   import 'EditBioScreen.dart';
//
//   class ProfileScreen extends StatefulWidget {
//     const ProfileScreen({super.key});
//
//     @override
//     State<ProfileScreen> createState() => _ProfileScreenState();
//   }
//
//   class _ProfileScreenState extends State<ProfileScreen> {
//
//     @override
//     void initState() {
//       super.initState();
//       Future.microtask(() {
//         context.read<ExperienceProvider>().loadExperiences();
//         context.read<QualificationProvider>().fetchMyQualifications();
//         context.read<SkillProvider>().loadMySkills(); // ← add this
//       });
//     }
//     void _editBio(BuildContext context, User u) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => EditBioScreen(initialBio: u.bio ?? ''),
//         ),
//       );
//     }
//
//     @override
//     Widget build(BuildContext context) {
//       final isDark       = JDeviceUtils.isDarkMode(context);
//       final userProvider = context.watch<AuthProvider>();
//       final user         = userProvider.currentUser;
//
//       return Scaffold(
//         appBar: JAppbar(
//           title: Text(
//             'profile',
//             textAlign: TextAlign.start,
//             style: AppTextStyle.dmSans(
//               fontSize: JSizes.fontSizeLg,
//               weight: FontWeight.bold,
//               color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             ),
//           ).tr(),
//           leadingIcon: const Icon(Icons.arrow_back),
//           leadingOnPressed: () => Navigator.pop(context),
//           actions: [
//             if (user != null)
//               IconButton(
//                 tooltip: 'Edit Profile',
//                 onPressed: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => EditAllProfileScreen(user: user),
//                   ),
//                 ),
//                 icon: Icon(
//                   Icons.edit_outlined,
//                   color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                 ),
//               ),
//           ],
//         ),
//         backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
//         body: user == null
//             ? ErrorState(
//           onRetry: () => context.read<AuthProvider>().getMe(),
//           isDark: isDark,
//         )
//             : SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ProfileHeader(isDark: isDark),
//
//                 ProfileSection(
//                   iconPath: JImages.edit_iconSvg,
//                   title: 'bio',
//                   content: ProfileBio(isDark: isDark),
//                   isDark: isDark,
//                 ),
//
//                 ProfileSection(
//                   iconPath: JImages.edit_iconSvg,
//                   title: 'workHistory',
//                   isDark: isDark,
//                   content: WorkHistoryList(isDark: isDark),
//                   voidCallback: () => showWorkExperienceBottomSheet(context ,isDark),
//
//
//                 ),
//
//                 ProfileSection(
//                   iconPath: JImages.edit_iconSvg,
//                   title: 'education',
//                   content: EducationList(isDark: isDark),
//                   isDark: isDark,
//                   voidCallback: () => showEducationBottomSheet(context),
//
//
//                 ),
//
//                 ProfileSection(
//                   iconPath: JImages.edit_iconSvg,
//                   title: 'skills',
//                   content: SkillsList(isDark: isDark),
//                   voidCallback: () => showSkillsBottomSheet(context ,isDark),
//
//                   isDark: isDark,
//                 ),
//
//                 ProfileSection(
//                   iconPath: JImages.edit_iconSvg,
//                   title: 'languages',
//                   content: LanguagesList(isDark: isDark),
//                   isDark: isDark,
//                   voidCallback: () => AppRouter.router.push('/languageScreen'),
//                 ),
//
//                 ProfileSection(
//                   iconPath: '',
//                   title: 'workFeedback',
//                   content: FeedbackList(isDark: isDark),
//                   isDark: isDark,
//                 ),
//
//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//   }


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contract_app/presentation/features/users/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'package:job_contract_app/presentation/features/users/profile/widgets/education_list.dart';
import 'package:job_contract_app/presentation/features/users/profile/widgets/feedback_list.dart';
import 'package:job_contract_app/presentation/features/users/profile/widgets/languages_list.dart';
import 'package:job_contract_app/presentation/features/users/profile/widgets/profile_bio.dart';
import 'package:job_contract_app/presentation/features/users/profile/widgets/profile_header.dart';
import 'package:job_contract_app/presentation/features/users/profile/widgets/profile_section.dart';
import 'package:job_contract_app/presentation/features/users/profile/widgets/skills_list.dart';
import 'package:job_contract_app/presentation/features/users/profile/widgets/work_history_list.dart';

import '../../../../utils/common_widgets/ErrorState.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../account_screen/bottomsheet/showEducationBottomSheet.dart';
import '../account_screen/bottomsheet/showLanguageBottomSheet.dart';
import '../account_screen/bottomsheet/showSkillsBottomSheet.dart';
import '../account_screen/bottomsheet/showWorkExperienceBottomSheet.dart';
import '../providers/experience_provider.dart';
import '../../../../data/models/auth/login_res.dart';
import '../providers/language_provider.dart'; // ← new
import '../providers/qualification_provider.dart';
import '../providers/skill_provider.dart';
import 'EditAllProfileScreen.dart';
import 'EditBioScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ExperienceProvider>().loadExperiences();
      context.read<QualificationProvider>().fetchMyQualifications();
      context.read<SkillProvider>().loadMySkills();
      context.read<LanguageProvider>().fetchMyLanguages(); // ← new
    });
  }

  void _editBio(BuildContext context, User u) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditBioScreen(initialBio: u.bio ?? ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark       = JDeviceUtils.isDarkMode(context);
    final userProvider = context.watch<AuthProvider>();
    final user         = userProvider.currentUser;

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          'profile',
          textAlign: TextAlign.start,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.bold,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
          ),
        ).tr(),
        leadingIcon: const Icon(Icons.arrow_back),
        leadingOnPressed: () => Navigator.pop(context),
        actions: [
          if (user != null)
            IconButton(
              tooltip: 'Edit Profile',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditAllProfileScreen(user: user),
                ),
              ),
              icon: Icon(
                Icons.edit_outlined,
                color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              ),
            ),
        ],
      ),
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      body: user == null
          ? ErrorState(
        onRetry: () => context.read<AuthProvider>().getMe(),
        isDark: isDark,
      )
          : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileHeader(isDark: isDark),

              ProfileSection(
                iconPath: JImages.edit_iconSvg,
                title: 'bio',
                content: ProfileBio(isDark: isDark),
                isDark: isDark,
              ),

              ProfileSection(
                iconPath: JImages.edit_iconSvg,
                title: 'workHistory',
                isDark: isDark,
                content: WorkHistoryList(isDark: isDark),
                voidCallback: () =>
                    showWorkExperienceBottomSheet(context, isDark),
              ),

              ProfileSection(
                iconPath: JImages.edit_iconSvg,
                title: 'education',
                content: EducationList(isDark: isDark),
                isDark: isDark,
                voidCallback: () => showEducationBottomSheet(context),
              ),

              ProfileSection(
                iconPath: JImages.edit_iconSvg,
                title: 'skills',
                content: SkillsList(isDark: isDark),
                voidCallback: () =>
                    showSkillsBottomSheet(context, isDark),
                isDark: isDark,
              ),

              ProfileSection(
                iconPath: JImages.edit_iconSvg,
                title: 'languages',
                content: LanguagesList(isDark: isDark),
                isDark: isDark,
                // ← now opens the new language bottom sheet
                voidCallback: () =>
                    showLanguageBottomSheet(context, isDark),
              ),

              ProfileSection(
                iconPath: '',
                title: 'workFeedback',
                content: FeedbackList(isDark: isDark),
                isDark: isDark,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
