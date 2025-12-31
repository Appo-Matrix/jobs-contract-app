import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../routes/app_routes.dart';
import '../../providers/contract_provider.dart';
import '../widgets/contract_card.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

class PausedContractsPage extends StatefulWidget {
  const PausedContractsPage({super.key});

  @override
  State<PausedContractsPage> createState() => _PausedContractsPageState();
}

class _PausedContractsPageState extends State<PausedContractsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch paused contracts when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContractProvider>().fetchPausedContracts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Consumer<ContractProvider>(
      builder: (context, provider, child) {
        // Loading state
        if (provider.isLoading && provider.pausedContracts.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: JAppColors.primary,
            ),
          );
        }

        // Error state
        if (provider.errorMessage != null && provider.pausedContracts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48.0,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading contracts',
                  style: AppTextStyle.dmSans(
                    fontSize: 16.0,
                    weight: FontWeight.w600,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    provider.errorMessage ?? 'Unknown error occurred',
                    style: AppTextStyle.dmSans(
                      fontSize: 12.0,
                      color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                      weight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<ContractProvider>().fetchPausedContracts(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: JAppColors.primary,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final contracts = provider.pausedContracts;

        // Empty state
        if (contracts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pause_circle_outline,
                  size: 48.0,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                ),
                const SizedBox(height: 16),
                Text(
                  'No paused contracts',
                  style: AppTextStyle.dmSans(
                    fontSize: 16.0,
                    weight: FontWeight.w600,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You don\'t have any paused contracts',
                  style: AppTextStyle.dmSans(
                    fontSize: 12.0,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        // Data loaded - display contracts
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                JText.pausedContracts,
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeMd.toDouble(),
                  weight: FontWeight.w600,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Contract cards
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: contracts.length,
                itemBuilder: (context, index) {
                  final contract = contracts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: ContractCard(
                      status: contract.status.capitalize(),
                      name: contract.client,
                      jobTitle: contract.job,
                      dateRange: '${contract.startDate} - Paused',
                      salary: '\$${contract.paymentDetails.amount} ${contract.paymentDetails.currency}',
                      category: contract.jobCategory,
                      jobType: contract.jobType,
                      duration: contract.jobDuration,
                      location: contract.location,
                      contractorImage: contract.clientProfileImage,
                      showActions: true,
                      // View paused contract details (READ ONLY)
                      onViewDetailsPressed: () {
                        AppRouter.router.push('/contractDetailScreen', extra: {
                          'status': contract.status.capitalize(),
                          'contractId': contract.id,
                        });
                      },
                      onCardTap: () {
                        AppRouter.router.push('/contractDetailScreen', extra: {
                          'status': contract.status.capitalize(),
                          'contractId': contract.id,
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:job_contracts/utils/constants/text_strings.dart';
//
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/image_string.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/device/device_utility.dart';
// import '../../../../routes/app_routes.dart';
// import '../widgets/contract_card.dart';
//
// class PausedContractsPage extends StatelessWidget {
//   const PausedContractsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Title
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             JText.pausedContracts,
//             style: AppTextStyle.dmSans(
//               fontSize: JSizes.fontSizeMd,
//               weight: FontWeight.w600,
//               color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 16),
//
//         // Contract cards
//         Expanded(
//           child: ListView.builder(
//             itemCount: 1,
//             itemBuilder: (context, index) {
//               return ContractCard(
//                 status: 'Paused',
//                 name: 'Shehla Abbas',
//                 jobTitle: 'Architects Construction',
//                 dateRange: '12 May - Paused',
//                 salary: '\$20,000 - \$25,000',
//                 category: 'Real Estate',
//                 jobType: 'Hybrid',
//                 duration: 'Full-time',
//                 location: 'United States',
//                 contractorImage: JImages.image,
//                 showActions: true,
//                 // View paused contract details (READ ONLY)
//                 onViewDetailsPressed: () {
//                   AppRouter.router.push('/contractDetailScreen', extra: {
//                     'status': 'Paused',
//                   });
//                 },
//                 onCardTap: () {
//                   AppRouter.router.push('/contractDetailScreen', extra: {
//                     'status': 'Paused',
//                   });
//                 },
//               );
//
//
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
