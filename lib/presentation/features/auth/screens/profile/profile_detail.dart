import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/auth/screens/profile/widgets/awarded_year_row.dart';
import 'package:job_contracts/presentation/features/auth/screens/profile/widgets/certificate_input_section.dart';
import 'package:job_contracts/presentation/features/auth/screens/profile/widgets/profile_photo_section.dart';
import 'package:job_contracts/presentation/features/auth/screens/profile/widgets/resume_upload_section.dart';
import 'package:job_contracts/utils/common_widgets/appbar2.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import '../../../../../utils/common_widgets/main_button.dart';

import 'package:job_contracts/presentation/routes/app_routes.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  String? selectedYear;
  final List<String> years =
  List.generate(30, (index) => (DateTime.now().year - index).toString());

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final backgroundColor = isDark ? JAppColors.backGroundDark : Colors.white;
    final textColor = isDark ? JAppColors.lightGray100 : JAppColors.darkGray800;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: JAppBar2(title: 'back'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'profileDetails',
                style: AppTextStyle.dmSans(
                  color: textColor,
                  fontSize: 24.0,
                  weight: FontWeight.w600,
                ),
              ).tr(),
              const SizedBox(height: 32),

              /// Profile Photo
               ProfilePhotoSection(isDark: isDark,),

              const SizedBox(height: 32),

              ResumeUploadSection(isDark: isDark, textColor: textColor, secondaryTextColor: JAppColors.lightGray400),
              const SizedBox(height: 32),

              CertificateInputSection(isDark: isDark),



              const SizedBox(height: 48),

              AwardedYearRow(
                isDark: isDark,
                selectedYear: selectedYear,
                years: years,
                textColor: textColor,
                onYearChange: (String? newValue) {
                  setState(() {
                    selectedYear = newValue;
                  });
                },
              ),


              const SizedBox(height: 48),

              /// Next Button
              MainButton(
                onTap: () {
                  AppRouter.router.push('/uploadPortfolioScreen');
                },
                btn_title: 'nextStep',
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: const Color(0xff7030F1),
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
