import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/features/users/myads/tabs_screen/active_ads_screen.dart';
import 'package:job_contracts/presentation/features/users/myads/tabs_screen/araft_ads_screen.dart';
import 'package:job_contracts/presentation/features/users/myads/tabs_screen/paused_ads_screen.dart';
import 'package:job_contracts/presentation/features/users/myads/widgets/ad_card.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/constants/sizes.dart';
import 'model/ad.dart';

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
    final sampleAd = Ad(
      title: 'Electrician Needed',
      category: 'Electrical Work',
      price: 2500.00,
      imageUrl: 'assets/images/sample_ad.jpg',
      id: '1', // Replace with a valid image
    );
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
        leadingIcon: Icon(Icons.arrow_back),
        leadingOnPressed: () {
          Navigator.pop(context);
        },
        actions: [
          CircularAvatar(
            isDark: isDark,
            radius: 20,
            imageUrl: JImages.image,
          ),
          SizedBox(
            width: 16,
          )
        ],
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.only(right: 16),
        //     height: 32,
        //     width: 110,
        //     child: ElevatedButton(
        //       onPressed: () {
        //         AppRouter.router.push('/createAdScreen');
        //       },
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: JAppColors.primary,
        //         foregroundColor: Colors.white,
        //         elevation: 0,
        //         padding: EdgeInsets.zero,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(8),
        //         ),
        //       ),
        //       child: Text(
        //         'createAd',
        //         style: AppTextStyle.dmSans(
        //           color: Colors.white,
        //           fontSize: 14.0,
        //           weight: FontWeight.w400,
        //         ),
        //       ).tr(),
        //     ),
        //   ),
        // ],
        // leadingIcon: Padding(
        //   padding: const EdgeInsets.all(2.0),
        //   child: BackCircle(
        //     isDark: isDark,
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab Bar with left-aligned scrollable tabs
            GestureDetector(
              onTap: () {
                // Navigate to full search screen
              },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      JImages.search,
                      width: 18,
                      height: 18,
                      colorFilter: ColorFilter.mode(
                        isDark
                            ? JAppColors.lightGray100
                            : JAppColors.darkGray800,
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
                          color: isDark
                              ? JAppColors.darkGray100
                              : JAppColors.lightGray500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      JImages.filters,
                      width: 18,
                      height: 18,
                      colorFilter: ColorFilter.mode(
                        isDark
                            ? JAppColors.lightGray100
                            : JAppColors.darkGray800,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Ads',
                  style: AppTextStyle.dmSans(
                    fontSize: 18.0,
                    weight: FontWeight.w700,
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.darkGray800,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: JAppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: (){

                      AppRouter.router.push('/createAdScreen');
                    },
                    child: Text(
                      'Post a new Ad',
                      style: AppTextStyle.dmSans(
                        fontSize: 12.0,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            AdCard(
              ad: sampleAd,
              isDark: isDark,
              onViewDetails: () {
                // Handle view details
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('View Details clicked')),
                );
              },
              onApply: () {
                // Handle apply
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Apply clicked')),
                );
              },
              onSave: () {
                // Handle save
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Save clicked')),
                );
              },
              location: 'New York, USA',
              date: 'Nov 10, 2025',
            ),

            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Container(
            //     height: 35,
            //     margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            //     child: TabBar(
            //       dividerColor: Colors.transparent,
            //       controller: _tabController,
            //       isScrollable: true,
            //       tabAlignment: TabAlignment.start,
            //       indicator: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: JAppColors.primary,
            //       ),
            //       indicatorSize: TabBarIndicatorSize.tab,
            //       labelColor: Colors.white,
            //       unselectedLabelColor:
            //           isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            //       padding: const EdgeInsets.all(3),
            //       indicatorWeight: 0,
            //       labelStyle: AppTextStyle.dmSans(
            //         fontSize: JSizes.fontSizeESm,
            //         weight: FontWeight.w500,
            //         color: Colors.white,
            //       ),
            //       unselectedLabelStyle: AppTextStyle.dmSans(
            //         fontSize: JSizes.fontSizeESm,
            //         weight: FontWeight.w500,
            //         color:
            //             isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            //       ),
            //       tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
            //     ),
            //   ),
            // ),
            //
            // const SizedBox(height: 16),
            //
            // // TabBarView with separate screen components
            // Expanded(
            //   child: TabBarView(
            //     controller: _tabController,
            //     children: [
            //       // Active Ads Tab
            //       ActiveAdsScreen(isDark: isDark),
            //
            //       // Draft Ads Tab
            //       DraftAdsScreen(isDark: isDark),
            //
            //       // Paused Ads Tab
            //       PausedAdsScreen(isDark: isDark),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
