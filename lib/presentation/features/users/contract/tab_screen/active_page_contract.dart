import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../widgets/contract_card.dart';
import '../widgets/deliver_contract_dialog.dart';
import '../widgets/feedback_dialog.dart';

class ActiveContractsPage extends StatelessWidget {
  const ActiveContractsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        const SizedBox(height: 16),

        // Contract cards
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: ContractCard(
                  status: 'Active',
                  name: 'Shehla Abbas',
                  jobTitle: 'Architects Construction',
                  dateRange: '12 May',
                  salary: '\$20,000 - \$25,000',
                  category: 'Real Estate',
                  jobType: 'Hybrid',
                  duration: 'Full-time',
                  location: 'United States',
                  contractorImage: JImages.image,
                  showActions: true,

                  // BUTTON 1: "Submit Work" (Primary Blue Button)
                  onSubmitWorkPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeliverContractDialog(
                        isDark: isDark,
                      ),
                    ).then((result) {
                      if (result != null) {
                        // Handle the result
                        print('File: ${result['file']?.name}');
                        print('Message: ${result['message']}');

                        // Show feedback dialog after successful delivery
                        _showFeedbackDialog(context, isDark);
                      }
                    });
                    // AppRouter.router.push('/submitWorkScreen', extra: {
                    //   'status': 'Active',
                    //   'contractId': 'contract_123',
                    // });
                  },

                  // BUTTON 2: "View Contract Details" (Outlined Button)
                  onViewDetailsPressed: () {
                    AppRouter.router.push('/contractDetailScreen', extra: {
                      'status': 'Active',
                      'contractId': 'contract_123',
                    });
                  },
                ),
              );
            },
          ),
        ),
        // In your list/screen where you use ContractCard:
      ],
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
        // Handle feedback result
        print('Rating: ${result['rating']}');
        print('Likes: ${result['likes']}');
        print('Dislikes: ${result['dislikes']}');
        print('Review: ${result['review']}');

        // Show success message or navigate
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Thank you for your feedback!'),
            backgroundColor: JAppColors.success600,
          ),
        );

        // Optionally navigate back
        // Navigator.pop(context);
      }
    });
  }


}
