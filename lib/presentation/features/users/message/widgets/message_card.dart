import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../model/message_data.dart';

class MessageCard extends StatelessWidget {
  final MessageData data;
  final bool isDark;
  final VoidCallback onTap;

  const MessageCard({
    super.key,
    required this.data,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(data.avatar),
                ),
                if (data.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? JAppColors.darkGray800 : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: AppTextStyle.dmSans(
                      fontSize: 16.0,
                      weight: FontWeight.w500,
                      color: isDark ? Colors.white : JAppColors.lightGray900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.message,
                    style: AppTextStyle.dmSans(
                      fontSize: 12.0,
                      weight: FontWeight.w400,
                      color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Time and unread count
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.time,
                  style: AppTextStyle.dmSans(
                    fontSize: 12.0,
                    weight: FontWeight.w300,
                    color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: JAppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    data.unreadCount.toString(),
                    style: AppTextStyle.dmSans(
                      fontSize: 10.0,
                      weight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}