import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/helpers/AvatarHelper.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import 'VerifyBadge.dart';

class ProfileHeader extends StatelessWidget {
  final bool isDark;

  const ProfileHeader({
    super.key,
    required this.isDark,
  });

  // ── Generate initials from fullName ────────────────────────────────────────

  // ── Pick a consistent color from the name ─────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    final bool hasImage =
        user?.profile != null && user!.profile.trim().isNotEmpty;
    final String initials = AvatarHelper.getInitials(user?.fullName);
    final Color avatarBg  = AvatarHelper.getColor(user?.fullName);
    // Verification statuses
    final bool isVerified         = user?.isVerified == true;
    final bool isEmailVerified    = user?.isEmailVerified == true;
    final bool isPhoneVerified    = user?.isPhoneVerified == true;
    final bool isIdentityVerified = user?.isIdentityVerified == true;
print("User data is ${user!.isVerified}    ${user.toJson()}");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [

          // ── Avatar ──────────────────────────────────────────────────────────
          Stack(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isVerified ? Colors.green : Colors.red,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: hasImage
                      ? Image.network(
                    user.profile,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        InitialsAvatar(initials: initials, color: avatarBg),
                  )
                  // No image → show initials circle
                      : InitialsAvatar(initials: initials, color: avatarBg),
                ),
              ),

              // ── Online dot ────────────────────────────────────────────────
              if (user.isOnline == true)
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Full Name ────────────────────────────────────────────────────────
          Text(
            user.fullName.isNotEmpty == true ? user.fullName : 'No Name',
            style: AppTextStyle.dmSans(
              fontSize: 20.0,
              weight: FontWeight.w600,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ),
          const SizedBox(height: 4),

          // ── Title / Specialty ────────────────────────────────────────────────
          if (user.title.isNotEmpty == true || user.specialty.isNotEmpty == true)
            Text(
              user.title.isNotEmpty == true
                  ? user.title
                  : user.specialty,
              style: AppTextStyle.dmSans(
                fontSize: 14.0,
                weight: FontWeight.w500,
                color: isDark ? JAppColors.darkGray400 : JAppColors.lightGray500,
              ),
            ),
          const SizedBox(height: 6),

          // ── Location ─────────────────────────────────────────────────────────
          if (user.city.isNotEmpty == true || user.country.isNotEmpty == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined, size: 14,
                    color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600),
                const SizedBox(width: 4),
                Text(
                  [
                    if (user.city.isNotEmpty == true) user.city,
                    if (user.country.isNotEmpty == true) user.country,
                  ].join(', '),
                  style: AppTextStyle.dmSans(
                    fontSize: 13.0,
                    weight: FontWeight.w400,
                    color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 6),

          // ── Earnings ──────────────────────────────────────────────────────────
          Text(
            'Earning: \$${user.earning ?? 0}',
            style: AppTextStyle.dmSans(
              fontSize: 14.0,
              weight: FontWeight.w400,
              color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
            ),
          ),
          const SizedBox(height: 12),

          // ── Verification Status Row ───────────────────────────────────────────
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              VerifyBadge(
                label: 'Account',
                verified: isVerified,
              ),
              VerifyBadge(
                label: 'Email',
                verified: isEmailVerified,
              ),
              VerifyBadge(
                label: 'Phone',
                verified: isPhoneVerified,
              ),
              VerifyBadge(
                label: 'Identity',
                verified: isIdentityVerified,
              ),
            ],
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
