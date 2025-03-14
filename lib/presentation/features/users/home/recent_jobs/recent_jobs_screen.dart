
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class RecentJobsPage extends StatelessWidget {
  const RecentJobsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final width =  MediaQuery.of(context).size.height ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 12),
          child: Text(
            'Recently Posted Jobs',
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
              return JobCard(
                title: "Plumbers Construction Specialists",
                description: "Hands-on Building Tasks.",
                salary: "\$20,000 - \$25,000",
                category: "Site Inspections",
                organization: "Contractors",
                companyName: "Appo Matrix",
                location: "Innovatown, Nevada",
                logoUrl: JImages.google1, // Replace with actual logo URL
                isVerified: true,
              );
            },
          ),
        ),
      ],
    );
  }
}


class JobCard extends StatelessWidget {
  final String title;
  final String description;
  final String salary;
  final String category;
  final String organization;
  final String companyName;
  final String location;
  final String logoUrl;
  final bool isVerified;

  const JobCard({
    Key? key,
    required this.title,
    required this.description,
    required this.salary,
    required this.category,
    required this.organization,
    required this.companyName,
    required this.location,
    required this.logoUrl,
    this.isVerified = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isDark ?JAppColors.lightGray600 : JAppColors.darkGray300,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Title


            Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: AppTextStyle.dmSans(
                color: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray700,
                fontSize: JSizes.fontSizeMd,
                weight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            // Description Container with Green Background
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                  decoration: BoxDecoration(

                    color: JAppColors.chartreuse200.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(10),


                  ),
                  child: Text(
                    description,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray700,
                      fontSize: 12.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),

                SizedBox(width: 8,),

                Text(
                  "Salary: $salary",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray700,
                    fontSize: 12.0,
                    weight: FontWeight.w400,
                  ),
                ),


              ],
            ),


            // Salary

            const SizedBox(height: 16),

            // Category and Organization
            Row(
              children: [
                Text(
                  "Category: ",
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray700,
                    fontSize: 10.0,
                    weight: FontWeight.w400,
                  ),
                ),
                Text(
                  category,
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.primary
                        : JAppColors.primary,
                    fontSize: 14.0,
                    weight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "Organization: ",
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray700,
                    fontSize: 10.0,
                    weight: FontWeight.w500,
                  ),
                ),
                Text(
                  organization,
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.primary
                        : JAppColors.primary,
                    fontSize: 12.0,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Company Logo and Name
            Row(
              children: [
                // Logo container
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(image: AssetImage(logoUrl))
                    // Image.network(
                    //   logoUrl,
                    //   fit: BoxFit.cover,
                    //   errorBuilder: (context, error, stackTrace) {
                    //     return Center(
                    //       child: Icon(
                    //         Icons.business,
                    //         color: Colors.white,
                    //         size: 30,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ),
                ),

                const SizedBox(width: 16),

                // Company name and verification
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          companyName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1D2939),
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF0C7),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFF79009), width: 2),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Color(0xFFF79009),
                              size: 20,
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: const Color(0xFF7839EE),
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF1D2939),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



// JobCard widget used by all pages
class JobCard1 extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String location;
  final String salary;
  final bool isRemote;
  final String postedTime;
  final bool isSaved;

  const JobCard1({
    Key? key,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.salary,
    required this.isRemote,
    required this.postedTime,
    this.isSaved = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray800 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    companyName.substring(0, 1),
                    style: AppTextStyle.dmSans(
                      fontSize: JSizes.fontSizeLg,
                      weight: FontWeight.bold,
                      color: JAppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: AppTextStyle.dmSans(
                        fontSize: JSizes.fontSizeSm,
                        color: isDark ? JAppColors.darkGray200 : JAppColors.lightGray600, weight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      jobTitle,
                      style: AppTextStyle.dmSans(
                        fontSize: JSizes.fontSizeMd,
                        weight: FontWeight.w600,
                        color: isDark ? Colors.white : JAppColors.lightGray900,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: isSaved ? JAppColors.primary : (isDark ? JAppColors.darkGray300 : JAppColors.lightGray500),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoChip(
                isDark,
                Icons.location_on_outlined,
                location,
              ),
              const SizedBox(width: 8),
              if (isRemote)
                _buildInfoChip(
                  isDark,
                  Icons.home_outlined,
                  'Remote',
                  isHighlighted: true,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoChip(
                isDark,
                Icons.monetization_on_outlined,
                salary,
              ),
              Text(
                postedTime,
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeEaSm,
                  color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray500, weight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(bool isDark, IconData icon, String label, {bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isHighlighted
            ? JAppColors.primary.withOpacity(0.1)
            : (isDark ? JAppColors.darkGray700 : JAppColors.lightGray100),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: isHighlighted
                ? JAppColors.primary
                : (isDark ? JAppColors.darkGray300 : JAppColors.lightGray600),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeXESm,
              weight: FontWeight.w500,
              color: isHighlighted
                  ? JAppColors.primary
                  : (isDark ? JAppColors.darkGray300 : JAppColors.lightGray600),
            ),
          ),
        ],
      ),
    );
  }
}