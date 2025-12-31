import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:provider/provider.dart';

import '../../providers/contract_provider.dart';
import '../widgets/contract_card.dart';
import '../widgets/deliver_contract_dialog.dart';
import '../widgets/feedback_dialog.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

class ActiveContractsPage extends StatefulWidget {
  const ActiveContractsPage({super.key});

  @override
  State<ActiveContractsPage> createState() => _ActiveContractsPageState();
}

class _ActiveContractsPageState extends State<ActiveContractsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch active contracts when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContractProvider>().fetchActiveContracts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Consumer<ContractProvider>(
      builder: (context, provider, child) {
        // Loading state
        if (provider.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: JAppColors.primary,
            ),
          );
        }

        // Error state
        if (provider.errorMessage != null && provider.activeContracts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
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
                Text(
                  provider.errorMessage ?? 'Unknown error occurred',
                  style: AppTextStyle.dmSans(
                    fontSize: 12.0,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                    weight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<ContractProvider>().fetchActiveContracts(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: JAppColors.primary,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final contracts = provider.activeContracts;

        // Empty state
        if (contracts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inbox_outlined,
                  size: 48,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                ),
                const SizedBox(height: 16),
                Text(
                  'No active contracts',
                  style: AppTextStyle.dmSans(
                    fontSize: 16.0,
                    weight: FontWeight.w600,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You don\'t have any active contracts yet',
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
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: contracts.length,
                itemBuilder: (context, index) {
                  final contract = contracts[index];
                  return // Update the ContractCard usage in your ListView.builder
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: ContractCard(
                        status: contract.status.capitalize(), // Use from DB: "active" -> "Active"
                        name: contract.client,
                        jobTitle: contract.job,
                        dateRange: contract.startDate,
                        salary: '\$${contract.paymentDetails.amount} ${contract.paymentDetails.currency}',
                        category: contract.jobCategory, // Use from DB instead of contract.job
                        jobType: contract.jobType, // Use from DB: "Hybrid", "Remote", "On-site"
                        duration: contract.jobDuration, // Use from DB: "Full-time" or "Part-time"
                        location: contract.location, // Use from DB: "United States"
                        contractorImage: contract.clientProfileImage,
                        showActions: true,
                        // BUTTON 1: "Submit Work"
                        onSubmitWorkPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => DeliverContractDialog(
                              isDark: isDark,
                            ),
                          ).then((result) {
                            if (result != null) {
                              print('File: ${result['file']?.name}');
                              print('Message: ${result['message']}');
                              _showFeedbackDialog(context, isDark);
                            }
                          });
                        },
                        // BUTTON 2: "View Contract Details"
                        onViewDetailsPressed: () {
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

  void _showFeedbackDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => FeedbackDialog(
        isDark: isDark,
      ),
    ).then((result) {
      if (result != null) {
        print('Rating: ${result['rating']}');
        print('Likes: ${result['likes']}');
        print('Dislikes: ${result['dislikes']}');
        print('Review: ${result['review']}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Thank you for your feedback!'),
            backgroundColor: JAppColors.success600,
          ),
        );
      }
    });
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:job_contracts/presentation/routes/app_routes.dart';
// import 'package:job_contracts/utils/constants/text_strings.dart';
//
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/image_string.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/device/device_utility.dart';
// import '../widgets/contract_card.dart';
// import '../widgets/deliver_contract_dialog.dart';
// import '../widgets/feedback_dialog.dart';
//
// class ActiveContractsPage extends StatelessWidget {
//   const ActiveContractsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//
//
//         const SizedBox(height: 16),
//
//         // Contract cards
//         Expanded(
//           child: ListView.builder(
//             itemCount: 3,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 18.0),
//                 child: ContractCard(
//                   status: 'Active',
//                   name: 'Shehla Abbas',
//                   jobTitle: 'Architects Construction',
//                   dateRange: '12 May',
//                   salary: '\$20,000 - \$25,000',
//                   category: 'Real Estate',
//                   jobType: 'Hybrid',
//                   duration: 'Full-time',
//                   location: 'United States',
//                   contractorImage: JImages.image,
//                   showActions: true,
//
//                   // BUTTON 1: "Submit Work" (Primary Blue Button)
//                   onSubmitWorkPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => DeliverContractDialog(
//                         isDark: isDark,
//                       ),
//                     ).then((result) {
//                       if (result != null) {
//                         // Handle the result
//                         print('File: ${result['file']?.name}');
//                         print('Message: ${result['message']}');
//
//                         // Show feedback dialog after successful delivery
//                         _showFeedbackDialog(context, isDark);
//                       }
//                     });
//                     // AppRouter.router.push('/submitWorkScreen', extra: {
//                     //   'status': 'Active',
//                     //   'contractId': 'contract_123',
//                     // });
//                   },
//
//                   // BUTTON 2: "View Contract Details" (Outlined Button)
//                   onViewDetailsPressed: () {
//                     AppRouter.router.push('/contractDetailScreen', extra: {
//                       'status': 'Active',
//                       'contractId': 'contract_123',
//                     });
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//         // In your list/screen where you use ContractCard:
//       ],
//     );
//   }
//   void _showFeedbackDialog(BuildContext context, bool isDark) {
//     showDialog(
//       context: context,
//       builder: (context) => FeedbackDialog(
//         isDark: isDark,
//       ),
//     ).then((result) {
//       if (result != null) {
//         // Handle feedback result
//         print('Rating: ${result['rating']}');
//         print('Likes: ${result['likes']}');
//         print('Dislikes: ${result['dislikes']}');
//         print('Review: ${result['review']}');
//
//         // Show success message or navigate
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Thank you for your feedback!'),
//             backgroundColor: JAppColors.success600,
//           ),
//         );
//
//         // Optionally navigate back
//         // Navigator.pop(context);
//       }
//     });
//   }
//
//
// }
