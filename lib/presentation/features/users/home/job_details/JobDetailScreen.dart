import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/EmployerProfileWidget.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: JSizes.appBarHeight),

              // Job Title
              Text(
                "Architects Construction",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.onest(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 18.0,
                  weight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),

              // Employer Profile
              EmployerProfileWidget(
                employerName: 'Amélie Laurent',
                location: 'United States',
                employerImage: JImages.image,
                isVerified: true,
                isDark: isDark,
              ),

              const SizedBox(height: 16),

              // Salary and Report section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Salary: ",
                        style: AppTextStyle.onest(
                          fontSize: 14.0,
                          weight: FontWeight.w400,
                          color: isDark ? Colors.white : JAppColors.lightGray900,
                        ),
                      ),
                      Text(
                        "\$20,000 - \$25,000",
                        style: AppTextStyle.onest(
                          fontSize: 14.0,
                          weight: FontWeight.w400,
                          color: isDark ? Colors.white : JAppColors.lightGray900,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      AppRouter.router.push('/reportJobScreen');
                    },
                    child: Text(
                      "reportJob",
                      style: AppTextStyle.onest(
                        fontSize: 14.0,
                        weight: FontWeight.w400,
                        color: JAppColors.error500,
                      ),
                    ).tr(),
                  )
                ],
              ),

              const SizedBox(height: 24),

              // Job Description Header and Apply Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "jobDescription",
                    style: AppTextStyle.onest(
                      fontSize: 16.0,
                      weight: FontWeight.w500,
                      color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                    ),
                  ).tr(),
                  GestureDetector(
                    onTap: () {
                      AppRouter.router.push('/jobDetailsPage');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4 - 20,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: JAppColors.primary,
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Center(
                        child: Text(
                          'applyJob',
                          style: AppTextStyle.dmSans(
                            color: Colors.white,
                            fontSize: 14.0,
                            weight: FontWeight.w500,
                          ),
                        ).tr(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Job Description Text
              Text(
                "We are seeking a highly motivated and skilled Architects & Construction Specialist to join our dynamic team. The ideal candidate will be responsible for providing expertise in architectural planning, construction project coordination, and ensuring high-quality project execution. This role involves working closely with contractors, engineers, and clients to ensure compliance with industry standards and best practices while delivering outstanding results.\n\nThe successful candidate will have extensive experience in construction management, architectural design principles, and project coordination. They should possess strong communication skills, attention to detail, and the ability to work effectively in a fast-paced environment. This position offers excellent opportunities for professional growth and development within a collaborative team setting.\n\nWe offer competitive compensation, comprehensive benefits, and the opportunity to work on exciting projects that make a real impact in the construction industry. Join our team and contribute to building exceptional structures while advancing your career in architecture and construction.",
                style: AppTextStyle.onest(
                  fontSize: 14.0,
                  height: 1.5,
                  weight: FontWeight.w400,
                  color: isDark ? Colors.white : JAppColors.lightGray900,
                ),
              ),

              const SizedBox(height: 24),

              // Location Section
              Text(
                "Location",
                style: AppTextStyle.onest(
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                ),
              ),

              const SizedBox(height: 12),

              // Map Section
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: isDark ? JAppColors.darkGray700 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      // Placeholder for map - you can replace this with actual map widget
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: isDark ? JAppColors.darkGray600 : Colors.grey.shade200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 48,
                              color: JAppColors.primary,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "United States",
                              style: AppTextStyle.onest(
                                fontSize: 16.0,
                                weight: FontWeight.w500,
                                color: isDark ? Colors.white : JAppColors.lightGray900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "San Francisco, CA",
                              style: AppTextStyle.onest(
                                fontSize: 14.0,
                                weight: FontWeight.w400,
                                color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Map overlay for interactivity
                      // Positioned(
                      //   top: 12,
                      //   right: 12,
                      //   child: Container(
                      //     padding: const EdgeInsets.all(8),
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(8),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.black.withOpacity(0.1),
                      //           blurRadius: 4,
                      //           offset: const Offset(0, 2),
                      //         ),
                      //       ],
                      //     ),
                      //     child: Icon(
                      //       Icons.open_in_new,
                      //       size: 16,
                      //       color: JAppColors.primary,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),


          MainButton(
            onTap: (){
              AppRouter.router.push('/jobDetailsPage');


            },
            btn_title: 'applyJob',
            btn_radius: 10,
            btn_color: JAppColors.main,
            btn_border_color: const Color(0xff7030F1),
            title_color: Colors.white,
            text_fontweight: FontWeight.w600,
            image_value: false,
          ),

              // Apply Button

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}