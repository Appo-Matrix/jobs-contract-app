// widgets/ConversationTile.dart

import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class ConversationTile extends StatelessWidget {
  final bool isDark;
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;       // ✅ added
  final VoidCallback onTap;

  const ConversationTile({
    super.key,
    required this.isDark,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,  // ✅ added
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasUnread = unreadCount > 0;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [

            // ── Avatar + online dot ──────────────────────────
            Stack(
              children: [
                _buildAvatar(),
                if (isOnline)
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
                          color: isDark ? Colors.black : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // ── Name + last message ──────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyle.dmSans(
                      fontSize: 15.0,
                      weight: FontWeight.w600,
                      color: isDark ? Colors.white : JAppColors.lightGray900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage.isEmpty ? 'No messages yet' : lastMessage,
                    style: AppTextStyle.dmSans(
                      fontSize: 12.0,
                      weight: hasUnread ? FontWeight.w600 : FontWeight.w400,
                      color: hasUnread
                          ? (isDark ? Colors.white : JAppColors.lightGray900)
                          : (isDark
                          ? JAppColors.lightGray100
                          : JAppColors.lightGray600),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // ── Time + unread badge ──────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: AppTextStyle.dmSans(
                    fontSize: 11.0,
                    weight: FontWeight.w300,
                    color: isDark
                        ? JAppColors.lightGray100
                        : JAppColors.lightGray600,
                  ),
                ),
                const SizedBox(height: 6),
                if (hasUnread)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: JAppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$unreadCount',
                      style: AppTextStyle.dmSans(
                        fontSize: 10.0,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 22),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (avatarUrl.isNotEmpty && avatarUrl.startsWith('http')) {
      return CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[300],
        backgroundImage: NetworkImage(avatarUrl),
      );
    }
    // Initials fallback
    final parts = name.trim().split(' ');
    final initials = parts.length >= 2
        ? '${parts[0][0]}${parts[1][0]}'
        : name.isNotEmpty
        ? name[0]
        : '?';
    return CircleAvatar(
      radius: 24,
      backgroundColor: JAppColors.primary,
      child: Text(
        initials.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}