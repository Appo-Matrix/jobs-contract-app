import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../recent_jobs/recent_jobs_screen.dart';


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
            'Recommended for you',
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeLg,
              weight: FontWeight.bold,
              color: isDark ? Colors.white : JAppColors.lightGray900,
            ),
          ),
        ),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: 5,
        //     itemBuilder: (context, index) {
        //       return JobCard(
        //         companyName: 'Company ${index + 1}',
        //         jobTitle: 'Software Developer',
        //         location: 'New York, NY',
        //         salary: '\$80k - \$120k',
        //         isRemote: index % 2 == 0,
        //         postedTime: '2 days ago',
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}