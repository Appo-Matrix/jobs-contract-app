import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: JSizes.appBarHeight - 20),
              Row(
                children: [
                  CircularAvatar(
                    isDark: isDark,
                    radius: 20,
                    imageUrl: 'assets/images/profile1.jpg',
                    // Or use asset: true and imagePath: 'assets/images/profile1.jpg' for asset images
                  ),

                  const Spacer(),

                  CircularAvatar(
                    isDark: isDark,
                    radius: 20,
                    imageUrl: 'assets/images/profile1.jpg',
                    // Or use asset: true and imagePath: 'assets/images/profile1.jpg' for asset images
                  ),
                ],
              ),

              const SizedBox(height: 16), // Add some spacing before the tab bar

              Container(
                height: 45,
                child: TabBar(
                  controller: _tabController, // Set the controller
                  // Add rounded indicator
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: JAppColors.primary,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white, // Set selected tab text color to white
                  unselectedLabelColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  padding: EdgeInsets.all(3),
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
              SizedBox(
                height: 300, // Set an appropriate height
                child: TabBarView(
                  controller: _tabController, // Same controller for TabBarView
                  children: [
                    // Content for first tab
                    const Center(child: Text('For You Content')),
                    // Content for second tab
                    const Center(child: Text('Friends Content')),
                    // Content for third tab
                    const Center(child: Text('For You Content 2')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}