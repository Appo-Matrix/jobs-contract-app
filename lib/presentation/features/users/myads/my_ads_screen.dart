import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/myads/widgets/ad_card.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/constants/sizes.dart'; // Make sure to import the sizes
import 'model/ad.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [JText.active, JText.drafts, JText.paused];

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
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.myAds,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            height: 32,
            width: 100,
            child: ElevatedButton(
              onPressed: () {

                AppRouter.router.push('/createAdScreen');
                // Add your button action here
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
                JText.createAd,
                style: AppTextStyle.dmSans(
                  color: Colors.white,
                  fontSize: 16.0,
                  weight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab Bar with left-aligned scrollable tabs (like in ContractsScreen)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 35,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: TabBar(

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

          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAdsList(AdStatus.active,isDark),
                _buildAdsList(AdStatus.draft,isDark),
                _buildAdsList(AdStatus.paused,isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdsList(AdStatus status , bool isDark) {
    // Here you would fetch ads with the given status
    // This is just an example implementation
    List<Ad> ads = _getMockAds(status);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ads.length,
      itemBuilder: (context, index) {
        final ad = ads[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AdCard(
            ad: ad,
            onViewDetails: () {
              // Navigate to ad details
            },
            onEditAd: () {
              // Navigate to edit ad screen
            }, isDark: isDark,
          ),
        );
      },
    );
  }

  List<Ad> _getMockAds(AdStatus status) {
    // This would be replaced with actual data from your backend
    return [
      Ad(
        id: '1',
        title: JText.adTitlePlaceholder,
        price: 1600,
        category: JText.labor,
        status: status,
        imageUrl: JImages.image,
      ),
      Ad(
        id: '1',
        title: JText.adTitlePlaceholder,
        price: 1600,
        category: JText.labor,
        status: status,
        imageUrl: JImages.image,
      ),
      Ad(
        id: '1',
        title: JText.adTitlePlaceholder,
        price: 1600,
        category: JText.labor,
        status: status,
        imageUrl: JImages.image,
      ),
      Ad(
        id: '1',
        title: JText.adTitlePlaceholder,
        price: 1600,
        category: JText.labor,
        status: status,
        imageUrl: JImages.image,
      ),
    ];
  }
}

enum AdStatus { active, draft, paused }
