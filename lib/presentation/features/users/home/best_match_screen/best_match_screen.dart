import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../routes/app_routes.dart';
import '../models/job_posting.dart';
import '../widget/job_posting_card.dart';

class BestMatchesPage extends StatelessWidget {
  const BestMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final List<JobPosting> jobPostings = [
      JobPosting(
        jobTitle: "Plumbers Construction Specialists",
        description: "Hands-on building and maintenance tasks...",
        salary: "\$20,000 - \$25,000",
        category: "Site Inspections",
        jobType: "Onsite",
        duration: "1 Month",
        employerName: "James Smith",
        location: "New York, USA",
        postedTime: "2 hrs ago",
        isVerified: true,
        employerImage: JImages.image,
      ),
      JobPosting(
        jobTitle: "Electrician for High Rise",
        description: "Experienced electrician for commercial buildings...",
        salary: "\$18,000 - \$22,000",
        category: "Electrical",
        jobType: "Remote",
        duration: "3 Months",
        employerName: "Amélie Laurent",
        location: "California, USA",
        postedTime: "4 hrs ago",
        isVerified: false,
        employerImage: JImages.image,
      ),
      JobPosting(
        jobTitle: "HVAC Technician",
        description: "Install and maintain heating, ventilation, and air conditioning systems.",
        salary: "\$15,000 - \$20,000",
        category: "Maintenance",
        jobType: "Hybrid",
        duration: "2 Months",
        employerName: "Carlos Gonzalez",
        location: "Texas, USA",
        postedTime: "1 day ago",
        isVerified: true,
        employerImage: JImages.image,
      ),
      JobPosting(
        jobTitle: "Interior Designer",
        description: "Create functional and beautiful interior spaces for homes and offices.Create functional and beautiful interior spaces for homes and offices.Create functional and beautiful interior spaces for homes and offices.Create functional and beautiful interior spaces for homes and offices.Create functional and beautiful interior spaces for homes and offices.",
        salary: "\$25,000 - \$30,000",
        category: "Design",
        jobType: "Remote",
        duration: "6 Weeks",
        employerName: "Sophie Tan",
        location: "Toronto, Canada",
        postedTime: "5 hrs ago",
        isVerified: false,
        employerImage: JImages.image,
      ),
      JobPosting(
        jobTitle: "Site Supervisor",
        description: "Oversee daily operations on  d beautiful interior spaces for homes and offices.Create functional and beautiful interio d beautiful interior spaces for homes and offices.Create functional and beautiful interio d beautiful interior spaces for homes and offices.Create functional and beautiful interioconstruction sites.",
        salary: "\$30,000 - \$40,000",
        category: "Supervision",
        jobType: "Onsite",
        duration: "3 Months",
        employerName: "Liam Johnson",
        location: "Florida, USA",
        postedTime: "3 days ago",
        isVerified: true,
        employerImage: JImages.image,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 12),
          child: Text(
            'recommendedForYou',
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeLg,
              weight: FontWeight.w500,
              color: isDark ? Colors.white : JAppColors.lightGray900,
            ),
          ).tr(),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: jobPostings.length,
            itemBuilder: (context, index) {
              final job = jobPostings[index];
              return GestureDetector(
                onTap: () {
                  AppRouter.router.push('/jobDetailScreen');
                },
                child: JobPostingCard(
                  jobTitle: job.jobTitle,
                  description: job.description,
                  salary: job.salary,
                  category: job.category,
                  isVerified: job.isVerified,
                  employerImage: job.employerImage,
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
