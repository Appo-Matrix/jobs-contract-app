import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/home/recent_jobs/recent_jobs_screen.dart';
import 'package:job_contracts/presentation/features/users/home/saved_jobs/saved_jobs_screen.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import 'package:job_contracts/utils/common_widgets/appbar.dart';
import 'package:job_contracts/utils/common_widgets/back_circle.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import 'best_match_screen/best_match_screen.dart';
import 'drawer/widgets/drawer_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Initialize TabController in initState
    _tabController = TabController(length: 3, vsync: this);
  }
  

  @override
  void dispose() {
    // Dispose the controller when the widget is removed
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildNavigationDrawer(context, isDark),
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,

      appBar: JAppbar(
        leadingIcon: GestureDetector(
          onTap: ()=>{
          _scaffoldKey.currentState?.openDrawer()

        },
          child: CircularAvatar(
            isDark: isDark,
            radius: 20,
            imageUrl: JImages.image,
            // Or use asset: true and imagePath: 'assets/images/profile1.jpg' for asset images
          ),
        ),


        actions: [
          IconButton(
            icon:  Icon(Icons.more_vert, color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [


            SizedBox(
              height: 35,
              child: TabBar(
                controller: _tabController, // Set the controller
                // Add rounded indicator with no underline
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: JAppColors.primary,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white, // Set selected tab text color to white
                unselectedLabelColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                padding: EdgeInsets.all(3),
                indicatorWeight: 0, // Set to 0 to remove the underline
                labelStyle: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeESm,
                  weight: FontWeight.w500, color: Colors.white,
                ),
                unselectedLabelStyle: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeESm,
                  weight: FontWeight.w500, color: Colors.white,
                ),
                tabs: [
                  Tab(text: 'Best matches'),
                  Tab(text: 'Recent Jobs'),
                  Tab(text: 'Saved Jobs'),
                ],
              ),
            ),

            // Add a TabBarView to display content for each tab
            Expanded(
              child: TabBarView(
                controller: _tabController, // Same controller for TabBarView
                children: [
                  // Content for first tab
                  BestMatchesPage(),
                  RecentJobsPage(),
                  SavedJobsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
// Usage example for the navigation drawer
  Widget _buildNavigationDrawer(BuildContext context, bool isDark) {
    return Drawer(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,

      child: Column(
        children: [
          // Custom drawer header with profile in a row
          Container(

            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Close the drawer first

                        Navigator.pop(context);
                        // Navigate to profile screen
                        AppRouter.router.push('/profileScreen');
                      },
                      child: CircularAvatar(
                        isDark: isDark,
                        radius: 30,
                        imageUrl: JImages.image,
                      ),
                    ),                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: AppTextStyle.dmSans(
                            fontSize: JSizes.fontSizeMd,
                            weight: FontWeight.w600,
                            color:isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '@johndoe',
                          style: AppTextStyle.dmSans(
                            fontSize: 14.0,
                            weight: FontWeight.w400,
                            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),


          Divider(),
          // Drawer items using the custom widget
          DrawerItem(
            iconPath: JImages.profilesetting,
            title: 'Profile Settings',
            iconColor:isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);

              AppRouter.router.push('/accountSettingScreen');
              // Navigate to home
            },
          ),

          DrawerItem(
            iconPath: JImages.report,
            title: 'Financial Report',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/contactSupportScreen');

              // Navigate to profile
            },
          ),

          DrawerItem(
            iconPath: JImages.upgrade,
            title: 'Upgrade',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/membershipPlansScreen');
              // Navigate to applications
            },
          ),
          DrawerItem(
            iconPath: JImages.language,
            title: 'Language',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              AppRouter.router.push('/languageScreen');
              // Navigate to applications
            },
          ),

          DrawerItem(
            iconPath: JImages.helpsupport,
            title: 'Help & Support',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              // Navigate to notifications
            },
          ),


          DrawerItem(
            iconPath: JImages.logout_icon,
            title: 'Logout',
            iconColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),

        ],
      ),
    );
  }
}
