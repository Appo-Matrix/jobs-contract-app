import 'package:flutter/cupertino.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../widgets/contract_card.dart';

class CompletedContractsPage extends StatelessWidget {
  const CompletedContractsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Completed Contracts',
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeMd,
              weight: FontWeight.w600,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Contract cards
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ContractCard(
                status: 'Completed',
                name: 'Robert Johnson',
                jobTitle: 'Interior Design Specialist',
                dateRange: 'Mar 5 - Apr 10',
                salary: '\$15,000 - \$18,000',
                category: 'Interior Designer',
                jobType: 'Remote',
                duration: '5 Weeks',
                showActions: false,
              );
            },
          ),
        ),
      ],
    );
  }
}
