import 'package:flutter/cupertino.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../widgets/contract_card.dart';

class ActiveContractsPage extends StatelessWidget {
  const ActiveContractsPage({super.key});

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
            'Active Contracts',
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
            itemCount: 3,
            itemBuilder: (context, index) {
              return ContractCard(
                status: 'Active',
                name: 'Amélie Laurent',
                jobTitle: 'Architects Construction Specialist',
                dateRange: 'Jan 15 - Present',
                salary: '\$20,000 - \$25,000',
                category: 'Electrician',
                jobType: 'Onsite',
                duration: '1 Month',
                showActions: true,
              );
            },
          ),
        ),
      ],
    );
  }
}