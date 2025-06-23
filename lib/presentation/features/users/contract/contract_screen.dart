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
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      key: scaffoldKey,
      drawer: CustomNavigationDrawer(isDark: isDark),  // Use the new drawer widget
      appBar: JAppbar(
        title: Text(
          'allContract',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w500,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
          ),
        ).tr(),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    JImages.search,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'searchContracts',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                            color:
                                isDark ? JAppColors.lightGray100 : Colors.grey),
                      ),
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tab Bar with left-aligned scrollable tabs
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 35,
              margin: const EdgeInsets.only(left: 16, right: 16),
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
    );
  }


}
