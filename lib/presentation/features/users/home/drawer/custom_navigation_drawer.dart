import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_contract_app/presentation/features/users/providers/auth_provider.dart';
import 'package:job_contract_app/presentation/features/users/home/drawer/widgets/drawer_item.dart';
import 'package:job_contract_app/presentation/routes/routes.dart';

import 'package:provider/provider.dart';

import '../../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/AvatarHelper.dart';
import '../../../../routes/app_routes.dart';
import '../../providers/user_provider.dart';
import '../bottom_sheet/app_bottom_sheets.dart';

class CustomNavigationDrawer extends StatefulWidget {
  final bool isDark;

  const CustomNavigationDrawer({
    super.key,
    required this.isDark,
  });

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  @override
  void initState() {
    super.initState();
    // Fetch current user profile when drawer is initialized


  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: widget.isDark ? JAppColors.darkGray800 : Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Custom drawer header with profile in a row
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Consumer<AuthProvider>(
                    builder: (context, userProvider, child) {
                      return Row(
                        children: [
                          CircularAvatar(
                            isDark: widget.isDark,
                            radius: 30,
                            imageUrl: userProvider.currentUser?.profile ?? "",
                            isNetworkImage: true,
                            initials: AvatarHelper.getInitials(
                              userProvider.currentUser?.fullName,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userProvider.currentUser?.fullName ?? 'User',
                                  style: AppTextStyle.dmSans(
                                    fontSize: JSizes.fontSizeMd,
                                    weight: FontWeight.w600,
                                    color: widget.isDark
                                        ? JAppColors.darkGray100
                                        : JAppColors.lightGray800,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '@${(userProvider.currentUser?.fullName ?? 'user').toLowerCase().replaceAll(' ', '')}',
                                  style: AppTextStyle.dmSans(
                                    fontSize: 14.0,
                                    weight: FontWeight.w400,
                                    color: widget.isDark
                                        ? JAppColors.darkGray100
                                        : JAppColors.lightGray800,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const Divider(),
            // Drawer items using the custom widget
            DrawerItem(
              iconPath: JImages.profilesetting,
              title: 'accountSetting',
              iconColor: widget.isDark
                  ? JAppColors.darkGray100
                  : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/accountSettingScreen');
              },
            ),
            DrawerItem(
              iconPath: JImages.report,
              title: 'financialReport',
              iconColor: widget.isDark
                  ? JAppColors.darkGray100
                  : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/financeReportScreen');
              },
            ),
            DrawerItem(
              iconPath: JImages.proposal,
              title: 'proposal',
              iconColor: widget.isDark
                  ? JAppColors.darkGray100
                  : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/proposalsOffersScreen');
              },
            ),
            DrawerItem(
              iconPath: JImages.proposal,
              title: 'myAds',
              iconColor: widget.isDark
                  ? JAppColors.darkGray100
                  : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/myAdsScreen');
              },
            ),
            DrawerItem(
              iconPath: JImages.upgrade,
              title: 'upgrade',
              iconColor: widget.isDark
                  ? JAppColors.darkGray100
                  : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/membershipPlansScreen');
              },
            ),
            DrawerItem(
              iconPath: JImages.language,
              title: 'language',
              iconColor: widget.isDark
                  ? JAppColors.darkGray100
                  : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/languageScreen');
              },
            ),
            DrawerItem(
              iconPath: JImages.helpsupport,
              title: 'helpAndSupport',
              iconColor: widget.isDark
                  ? JAppColors.darkGray100
                  : JAppColors.lightGray800,
              onTap: () {
                Navigator.pop(context);
                AppRouter.router.push('/contactSupportScreen');
              },
            ),
            DrawerItem(
              iconPath: JImages.logout_icon,
              title: 'logout',
              iconColor: widget.isDark
                  ? JAppColors.darkGray100
                  : JAppColors.lightGray800,
              onTap: () async {
                Navigator.pop(context);

                final authProvider = context.read<AuthProvider>();

                try {
                  final success = await authProvider.logoutUser();

                  if (success) {
                    // ✅ Clear in-memory user state
                    authProvider.logoutUser();

                    // ✅ Go to onboarding, clears entire back stack
                    AppRouter.router.go('/onboardingScreen');
                  } else {
                    Fluttertoast.showToast(msg: 'Logout failed. Please try again.');
                  }
                } catch (e) {
                  Fluttertoast.showToast(msg: 'Logout failed: $e');
                }
              },
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🌗 Theme Button
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context); // Close drawer
                      AppBottomSheets.showThemeBottomSheet(context, widget.isDark);
                    },
                    icon: Icon(
                      Icons.brightness_6_outlined,
                      color: widget.isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                    ),
                    label: Text(
                      'Theme',
                      style: AppTextStyle.dmSans(
                        fontSize: 14.0,
                        weight: FontWeight.w500,
                        color: widget.isDark
                            ? JAppColors.darkGray100
                            : JAppColors.lightGray800,
                      ),
                    ),
                  ),
                  // 🌍 Language Button
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context); // Close drawer
                      AppBottomSheets.showLanguageBottomSheet(
                          context, widget.isDark);
                    },
                    icon: Icon(
                      Icons.language,
                      color: widget.isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                    ),
                    label: Text(
                      'Language',
                      style: AppTextStyle.dmSans(
                        fontSize: 14.0,
                        weight: FontWeight.w500,
                        color: widget.isDark
                            ? JAppColors.darkGray100
                            : JAppColors.lightGray800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


