import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/back_circle.dart';
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
    // Colors

    final isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Architects Construction.",
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 19.0,
            weight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image with Red Circle Border
                  Container(
                    width: 53,
                    height: 53,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      border: Border.all(
                        width: 1,
                        color: JAppColors.darkGray400
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        JImages.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Name and location
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Amélie Laurent",
                              style: AppTextStyle.dmSans(
                                fontSize: 19.0,
                                weight: FontWeight.w500,
                                color: isDark
                                    ? Colors.white
                                    : JAppColors.lightGray800,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Image(
                                height: 20,
                                width: 20,
                                image: AssetImage(JImages.verify)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SvgPicture.asset(
                              JImages.locationSvg,
                              height: 20,
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                isDark
                                    ? JAppColors.lightGray100
                                    : JAppColors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "United States",
                              style: AppTextStyle.dmSans(
                                fontSize: 16.0,
                                weight: FontWeight.w400,
                                color: isDark
                                    ? Colors.white
                                    : JAppColors.lightGray900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Bookmark button
                  IconButton(
                    icon: const Icon(
                      Icons.bookmark_border,
                      size: 28,
                    ),
                    color: isDark ? Colors.white : JAppColors.lightGray900,
                    onPressed: () {},
                  ),
                ],
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
                        style: AppTextStyle.dmSans(
                          fontSize: 14.0,
                          weight: FontWeight.w400,
                          color: isDark ? Colors.white : JAppColors.lightGray900,
                        ),
                      ),
                      Text(
                        "\$20,000 - \$25,000",
                        style: AppTextStyle.dmSans(
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
                      "Report Job",
                      style: AppTextStyle.dmSans(
                        fontSize: 14.0,
                        weight: FontWeight.w400,
                        color: JAppColors.error500,
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // This ensures equal spacing between the widgets
                crossAxisAlignment: CrossAxisAlignment.center,
                // Center align items vertically if needed
                children: [
                  Text(
                    "Job Description",
                    // Using literal text instead of JText.jobDescription
                    style: AppTextStyle.dmSans(
                      fontSize: 20.0,
                      weight: FontWeight.w600,
                      color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppRouter.router.push('/jobDetailsPage');
                    },
                    child: Container(

                      width: MediaQuery.of(context).size.width *
                          0.4 -20, // Adjust the width as needed
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: JAppColors.primary, // Color(0xff7030F1),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Center(
                        // Centering the text inside the container
                        child: Text(
                          JText.applyJob,
                          style: AppTextStyle.dmSans(
                            color: Colors.white,
                            fontSize: 16.0,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description text
              Text(

                "We are seeking a highly motivated and skilled Architects & Construction Specialist to join our dynamic team. The ideal candidate will be responsible for providing expertise in architectural planning, construction project coordination, and ensuring high-quality project execution. This role involves working closely with contractors, engineers, and clients to ensure compliance with industry standards and best practices while delivering outstanding results.",
                style: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  height:   1.2,
                  weight: FontWeight.w400,
                  color: isDark ? Colors.white : JAppColors.lightGray900,
                ),
              ),

              const SizedBox(height: 16),

              // Responsibilities section
              Text(
                "Responsibilities:",
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.bold,
                  color: isDark ? Colors.white : JAppColors.lightGray900,
                ),
              ),

              const SizedBox(height: 8),

              // Responsibilities list
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBulletPoint(
                    "Provide technical guidance on architectural designs, construction materials, and project execution.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Collaborate with construction teams, engineers, and contractors to ensure project specifications are met.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Review and troubleshoot construction challenges, proposing effective solutions.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Assist clients in project planning, design selection, and material recommendations.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Ensure compliance with building codes, safety regulations, and industry standards.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Document and track project progress, issues, and resolutions.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Stay updated on construction trends, sustainability practices, and emerging technologies.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Provide training and guidance to construction teams and junior professionals on best practices.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Requirements section
              Text(
                "Requirements:",
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.bold,
                  color: isDark ? Colors.white : JAppColors.lightGray900,
                ),
              ),

              const SizedBox(height: 8),

              // Requirements list
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBulletPoint(
                    "Bachelor's degree in Architecture, Civil Engineering, or a related field; or equivalent work experience.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Proven experience as an Architect, Construction Specialist, or in a similar role.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Strong knowledge of construction techniques, building materials, and structural integrity.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Familiarity with CAD software, architectural design principles, and construction blueprints.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Excellent communication skills, both verbal and written, to interact with teams and clients effectively.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "A customer-focused attitude with a commitment to high-quality service.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Ability to work independently and collaboratively in a fast-paced environment.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Strong problem-solving skills with keen attention to detail.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Familiarity with project management tools and remote collaboration techniques.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildBulletPoint(
                    "Certifications such as LEED, PMP, or relevant industry certifications are a plus.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Additional responsibilities title
              Text(
                "Responsibilities:",
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.bold,
                  color: isDark ? Colors.white : JAppColors.lightGray900,
                ),
              ),

              const SizedBox(height: 8),

              // Additional responsibilities list
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNumberedPoint(
                    1,
                    "Provide first-level technical support to customers via phone, email, and chat.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildNumberedPoint(
                    2,
                    "Diagnose and troubleshoot software and hardware issues to ensure timely resolution.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                  _buildNumberedPoint(
                    3,
                    "Collaborate with cross-functional teams to escalate and resolve complex technical problems.",
                    isDark ? Colors.white : JAppColors.lightGray900,
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedPoint(int number, String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$number. ",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
