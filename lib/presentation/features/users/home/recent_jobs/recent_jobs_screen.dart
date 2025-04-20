
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../widget/job_posting_card.dart';

class RecentJobsPage extends StatelessWidget {
  const RecentJobsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final width =  MediaQuery.of(context).size.height ;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            decoration: BoxDecoration(
              color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  JImages.search,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: JText.searchJob,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: AppTextStyle.dmSans(
                        fontSize: JSizes.fontSizeMd,
                        weight: FontWeight.w400,
                        color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                      ),
                    ),
                    style: AppTextStyle.dmSans(
                      fontSize: JSizes.fontSizeMd,
                      weight: FontWeight.w400,
                      color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){},
                  child: SvgPicture.asset(
                    JImages.filters,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),

          Text(
            JText.recentPotJob,
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeLg,
              weight: FontWeight.bold,
              color: isDark ? Colors.white : JAppColors.lightGray900,
            ),
          ),


          SizedBox(height: 16,),

          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return JobPostingCard(
                  jobTitle: "Plumbers Construction Specialists",
                  description: "Hands-on Building Tasks. Hands-on Building Tasks. Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building TasksHands-on Building Tasks. Hands-on Building Tasks. Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building TasksHands-on Building Tasks. Hands-on Building Tasks. Hands-on Building Tasks.Hands-on Building Tasks.Hands-on Building Tasks.",
                  salary: "\$20,000 - \$25,000",
                  category: "Site Inspections",

                  isVerified: true, isDark: isDark,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


