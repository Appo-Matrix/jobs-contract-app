import 'package:flutter/material.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/device/device_utility.dart';

class AdContextMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  const AdContextMenu({
    Key? key,
    required this.onEdit,
    required this.onShare,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Edit Ad Option
          _buildMenuItem(
            context: context,
            icon: Icons.edit_outlined,
            label: 'Edit Ad',
            onTap: onEdit,
            isDark: isDark,
          ),

          // Share Ad Option
          _buildMenuItem(
            context: context,
            icon: Icons.share_outlined,
            label: 'Share Ad',
            onTap: onShare,
            isDark: isDark,
          ),

          const Divider(height: 1, thickness: 0.5),

          // Delete Ad Option
          _buildMenuItem(
            context: context,
            icon: Icons.delete_outline,
            label: 'Delete Ad',
            onTap: onDelete,
            isDestructive: true,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
    required bool isDark,
  }) {
    final Color textColor = isDestructive
        ? Colors.red
        : (isDark ? JAppColors.darkGray100 : JAppColors.lightGray900);

    return InkWell(
      onTap: () {
        // Close the menu
        Navigator.pop(context);
        // Execute the action
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: textColor,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyle.dmSans(
                color: textColor,
                fontSize: 14.0,
                weight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Usage example:
void showAdContextMenu(BuildContext context) {
  final isDark = JDeviceUtils.isDarkMode(context);

  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: AdContextMenu(
        onEdit: () {
          // Handle edit action
        },
        onShare: () {
          // Handle share action
        },
        onDelete: () {
          // Handle delete action
          // You might want to show a confirmation dialog here
        },
      ),
    ),
  );
}