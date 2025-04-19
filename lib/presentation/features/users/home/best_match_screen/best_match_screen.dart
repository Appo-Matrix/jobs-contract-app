import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/home/widget/RealEstateJobCard.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../recent_jobs/recent_jobs_screen.dart';
import '../widget/job_posting_card.dart';

class BestMatchesPage extends StatelessWidget {
  const BestMatchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 12),
          child: Text(
            JText.recommendedForYou,
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeLg,
              weight: FontWeight.bold,
              color: isDark ? Colors.white : JAppColors.lightGray900,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return
                GestureDetector(
                onTap: () {
                  AppRouter.router.push('/jobDetailScreen');
                },
                child: JobPostingCard(
                  jobTitle: "Plumbers Construction Specialists",
                  description:
                      "Hands-on Building Tasks. Hands-on Building Tasks. Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.",
                  salary: "\$20,000 - \$25,000",
                  category: "Site Inspections",
                  isVerified: true,
                  employerImage: JImages.image,
                  isDark: isDark,
                ),
              );
            },
          ),
        ),


      ],
    );
  }
}
