import 'package:flutter/cupertino.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import '../widgets/contract_card.dart';

class PausedContractsPage extends StatelessWidget {
  const PausedContractsPage({super.key});

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
            JText.pausedContracts,
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
                status: 'Paused',
                name: 'Shehla Abbas',
                jobTitle: 'Architects Construction',
                dateRange: '12 May - Paused',
                salary: '\$20,000 - \$25,000',
                category: 'Real Estate',
                jobType: 'Hybrid',
                duration: 'Full-time',
                location: 'United States',
                contractorImage: JImages.image,
                showActions: true,
                // View paused contract details (READ ONLY)
                onViewDetailsPressed: () {
                  AppRouter.router.push('/contractDetailScreen', extra: {
                    'status': 'Paused',
                  });
                },
                onCardTap: () {
                  AppRouter.router.push('/contractDetailScreen', extra: {
                    'status': 'Paused',
                  });
                },
              );


            },
          ),
        ),
      ],
    );
  }
}
