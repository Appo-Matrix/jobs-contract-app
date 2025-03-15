import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';

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
    ];
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.contactSupport,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.back,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Support Requests',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            // Table header
            Row(
              children: [
                const SizedBox(width: 40, child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(width: 16),
                const Expanded(child: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 80, child: Text('Created', style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 80, child: Text('Last Activity', style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 80, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(height: 16),
            // Table rows
            ...requests.map((request) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  SizedBox(width: 40, child: Text(request['id'])),
                  const SizedBox(width: 16),
                  Expanded(child: Text(request['subject'])),
                  SizedBox(width: 80, child: Text(request['created'])),
                  SizedBox(width: 80, child: Text(request['lastActivity'])),
                  SizedBox(
                    width: 80,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: request['status'] == 'Solved' ? Colors.deepPurple[100] : Colors.orange[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        request['status'],
                        style: TextStyle(
                          color: request['status'] == 'Solved' ? Colors.deepPurple : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}