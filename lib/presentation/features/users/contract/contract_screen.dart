import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/presentation/features/users/contract/tab_screen/active_page_contract.dart';
import 'package:job_contracts/presentation/features/users/contract/tab_screen/cancelled_page_contract.dart';
import 'package:job_contracts/presentation/features/users/contract/tab_screen/complete_contract_page.dart';
import 'package:job_contracts/presentation/features/users/contract/tab_screen/paused_contract_page.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:provider/provider.dart';

import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../routes/app_routes.dart';
import '../home/drawer/custom_navigation_drawer.dart';
import '../home/drawer/widgets/drawer_item.dart';

class ContractsScreen extends StatefulWidget {
  const ContractsScreen({super.key});

  @override
  State<ContractsScreen> createState() => _ContractsScreenState();
}

class _ContractsScreenState extends State<ContractsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;


  final tabs = [
    'Active',
    'Completed',
    'Paused',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: JAppbar(
        title: Padding(
          padding: const EdgeInsets.only(left:16.0),
          child: Text(
            'allContract',
            style: AppTextStyle.dmSans(
              fontSize: 18.0,
              weight: FontWeight.w500,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            ),
          ).tr(),
        ),

        actions: [
          CircularAvatar(
            isDark: isDark,
            radius: 20,
            imageUrl: JImages.image,
          ),

          SizedBox(width: 16,)
        ],


      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0 ,horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Contracts',
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

                      AppRouter.router.push('/proposalsOffersScreen');

                    },
                    child: Text(
                      'Proposal & Offers',
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

            SizedBox(height: 12,),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 35,
                child: TabBar(
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  // Explicitly set alignment to start
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: JAppColors.primary.withValues(alpha: 0.9),
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
                  tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  ActiveContractsPage(),
                  CompletedContractsPage(),
                  PausedContractsPage(),
                  CancelledContractsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
