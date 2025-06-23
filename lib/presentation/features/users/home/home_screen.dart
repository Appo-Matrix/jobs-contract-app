import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_contracts/presentation/features/users/home/best_match_screen/best_match_screen.dart';
import 'package:job_contracts/presentation/features/users/home/recent_jobs/recent_jobs_screen.dart';
import 'package:job_contracts/presentation/features/users/home/saved_jobs/saved_jobs_screen.dart';
import 'package:job_contracts/utils/common_widgets/appbar.dart';
import 'package:job_contracts/utils/common_widgets/circular_avatar.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:provider/provider.dart';
import '../../../../theme_controller/ThemeNotifier.dart';
import '../../../../utils/constants/app_text_style.dart';
import 'bottom_sheet/FilterSelectionBottomSheet.dart';
import 'bottom_sheet/app_bottom_sheets.dart';
import 'drawer/custom_navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, List<String>> selectedFilters = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateFilters(Map<String, List<String>> newFilters) {
    setState(() {
      selectedFilters = newFilters;
    });
    print('Applied filters: $selectedFilters');
  }

  void showFilterBottomSheet() async {
    final result = await FilterSelectionBottomSheet.show(
      context,
      initialFilters: selectedFilters,
    );

    if (result != null) {
      updateFilters(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Container(
      color: isDark ? JAppColors.backGroundDark : Colors.white, // Set background for status bar area

      child: SafeArea(

        child: Scaffold(
          key: _scaffoldKey,
          drawer: CustomNavigationDrawer(isDark: isDark),
          backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60), // Set custom height
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? JAppColors.backGroundDark : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Drawer Icon
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        JImages.drawer,
                        colorFilter: ColorFilter.mode(
                          isDark ? Colors.white : JAppColors.primary,
                          BlendMode.srcIn,
                        ),
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Search View - Takes remaining space
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to full search screen
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              JImages.search,
                              width: 18,
                              height: 18,
                              colorFilter: ColorFilter.mode(
                                isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                easy.tr('searchJob'),
                                style: AppTextStyle.dmSans(
                                  fontSize: JSizes.fontSizeSm,
                                  weight: FontWeight.w400,
                                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () => showFilterBottomSheet(),
                              child: SvgPicture.asset(
                                JImages.filters,
                                width: 18,
                                height: 18,
                                colorFilter: ColorFilter.mode(
                                  isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Profile Image
                  CircularAvatar(
                    isDark: isDark,
                    radius: 20,
                    imageUrl: JImages.image,
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0 ,horizontal: 16.0),
            child: Column(
              children: [
                // Tab Bar
                SizedBox(
                  height: 35,
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: JAppColors.primary.withValues(alpha: 0.9),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                    padding: const EdgeInsets.all(3),
                    indicatorWeight: 0,
                    labelStyle: AppTextStyle.dmSans(
                      fontSize: JSizes.fontSizeESm,
                      weight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    unselectedLabelStyle: AppTextStyle.dmSans(
                      fontSize: JSizes.fontSizeESm,
                      weight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    tabs: [
                      Tab(text: tr('bestMatch')),
                      Tab(text: tr('recentMatch')),
                      Tab(text: tr('savedMatch')),
                    ],
                  ),
                ),

                // Tab Content - Scrollable
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BestMatchesPage(),
                      RecentJobsPage(),
                      SavedJobsPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}