import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/helpandsupport/widgets/support_request_card.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
// Import the new card component

class SupportRequestsScreen extends StatelessWidget {
  const SupportRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample request data
    final List<Map<String, dynamic>> requests = [
      {
        'id': '12f4',
        'subject': 'Thank You Your Account Hash Been Reinstated',
        'created': '1 hr ago',
        'lastActivity': '1 hr ago',
        'status': 'Solved',
      },
      {
        'id': '12f4',
        'subject': 'Thank You Your Account Hash Been Reinstated',
        'created': '1 hr ago',
        'lastActivity': '1 hr ago',
        'status': 'Solved',
      },
      {
        'id': '12f4',
        'subject': 'Thank You Your Account Hash Been Reinstated',
        'created': '1 hr ago',
        'lastActivity': '1 hr ago',
        'status': 'Pending',
      },
    ];
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.contactSupport,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: Padding(
          padding: const EdgeInsets.all(2.0),
          child: BackCircle(
            isDark: isDark,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  final isLastItem = index == requests.length - 1;

                  return SupportRequestCard(
                    request: request,
                    isDark: isDark,
                    isLastItem: isLastItem,
                    onTap: () {
                      // Handle tap on request
                      print('Tapped on request: ${request['id']}');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}