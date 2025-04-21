import 'package:flutter/cupertino.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../widgets/contract_card.dart';

class CancelledContractsPage extends StatelessWidget {
  const CancelledContractsPage({super.key});

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
            JText.completedContracts,
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
            itemCount: 1,
            itemBuilder: (context, index) {
              return ContractCard(
                status: 'Cancelled',
                name: 'Sarah Thompson',
                jobTitle: 'Landscape Design Project',
                dateRange: 'Apr 5 - Cancelled',
                salary: '\$22,000 - \$25,000',
                category: 'Landscape Designer',
                jobType: 'Hybrid',
                duration: '3 Months',
                showActions: false,
              );
            },
          ),
        ),
      ],
    );
  }
}
