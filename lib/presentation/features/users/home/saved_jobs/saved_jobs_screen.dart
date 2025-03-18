// SavedJobsPage.dart
import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../recent_jobs/recent_jobs_screen.dart';


class SavedJobsPage extends StatelessWidget {
   SavedJobsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saved Jobs',
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.bold,
                  color: isDark ? Colors.white : JAppColors.lightGray900,
                ),
              ),
              Text(
                'See all',
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeSm,
                  weight: FontWeight.w500,
                  color: JAppColors.primary,
                ),
              ),
            ],
          ),
        ),
        // Expanded(
        //   child: savedJobs.isEmpty
        //       ? _buildEmptyState(isDark)
        //       : ListView.builder(
        //     itemCount: savedJobs.length,
        //     itemBuilder: (context, index) {
        //       final job = savedJobs[index];
        //       return JobCard1(
        //         companyName: job['company'],
        //         jobTitle: job['title'],
        //         location: job['location'],
        //         salary: job['salary'],
        //         isRemote: job['isRemote'],
        //         postedTime: job['posted'],
        //         isSaved: true,
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 50,
            color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray400,
          ),
          SizedBox(height: 16),
          Text(
            'No saved jobs yet',
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeMd,
              weight: FontWeight.w500,
              color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Jobs you save will appear here',
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeSm,
              color: isDark ? JAppColors.darkGray400 : JAppColors.lightGray500, weight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Sample data for saved jobs
  final List<Map<String, dynamic>> savedJobs = [
    {
      'company': 'Google',
      'title': 'Senior Flutter Developer',
      'location': 'Mountain View, CA',
      'salary': '\$120k - \$160k',
      'isRemote': true,
      'posted': '3 days ago',
    },
    {
      'company': 'Facebook',
      'title': 'Mobile Engineer',
      'location': 'Menlo Park, CA',
      'salary': '\$110k - \$150k',
      'isRemote': false,
      'posted': '1 week ago',
    },
    {
      'company': 'Google',
      'title': 'Senior Flutter Developer',
      'location': 'Mountain View, CA',
      'salary': '\$120k - \$160k',
      'isRemote': true,
      'posted': '3 days ago',
    },
    {
      'company': 'Facebook',
      'title': 'Mobile Engineer',
      'location': 'Menlo Park, CA',
      'salary': '\$110k - \$150k',
      'isRemote': false,
      'posted': '1 week ago',
    },
    {
      'company': 'Google',
      'title': 'Senior Flutter Developer',
      'location': 'Mountain View, CA',
      'salary': '\$120k - \$160k',
      'isRemote': true,
      'posted': '3 days ago',
    },
    {
      'company': 'Facebook',
      'title': 'Mobile Engineer',
      'location': 'Menlo Park, CA',
      'salary': '\$110k - \$150k',
      'isRemote': false,
      'posted': '1 week ago',
    },
  ];
}
