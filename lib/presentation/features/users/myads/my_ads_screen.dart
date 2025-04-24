import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/myads/tabs_screen/active_ads_screen.dart';
import 'package:job_contracts/presentation/features/users/myads/tabs_screen/araft_ads_screen.dart';
import 'package:job_contracts/presentation/features/users/myads/tabs_screen/paused_ads_screen.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/constants/sizes.dart';


class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [tr('active'), tr('drafts'), tr('paused')];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          'myAds',
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ).tr(),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            height: 32,
            width: 110,
            child: ElevatedButton(
              onPressed: () {
                AppRouter.router.push('/createAdScreen');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: JAppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'createAd',
                style: AppTextStyle.dmSans(
                  color: Colors.white,
                  fontSize: 14.0,
                  weight: FontWeight.w400,
                ),
              ).tr(),
            ),
          ),
        ],
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab Bar with left-aligned scrollable tabs
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 35,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: JAppColors.primary,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor:
                isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
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
                  color:
                  isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                ),
                tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // TabBarView with separate screen components
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Active Ads Tab
                ActiveAdsScreen(isDark: isDark),

                // Draft Ads Tab
                DraftAdsScreen(isDark: isDark),

                // Paused Ads Tab
                PausedAdsScreen(isDark: isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}