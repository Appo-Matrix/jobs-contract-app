import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_contracts/presentation/features/users/home/best_match_screen/best_match_screen.dart';
import 'package:job_contracts/presentation/features/users/home/recent_jobs/recent_jobs_screen.dart';
import 'package:job_contracts/presentation/features/users/home/saved_jobs/saved_jobs_screen.dart';
import 'package:job_contracts/presentation/features/users/home/widget/job_posting_card.dart';
import 'package:job_contracts/utils/common_widgets/appbar.dart';
import 'package:job_contracts/utils/common_widgets/circular_avatar.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:provider/provider.dart';
import '../../../../theme_controller/ThemeNotifier.dart';
import '../../../../utils/common_widgets/blog_card.dart';
import '../../../../utils/common_widgets/job_card.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../routes/app_routes.dart';
import '../blog/blog_detail_screen.dart';
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
            preferredSize: const Size.fromHeight(60),
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Left: Drawer icon
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
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
                  ),

                  // Center: Title
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Text(
                      "Home",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  // Right: Notification + Profile
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Notification Icon
                        GestureDetector(
                          onTap: () {
                            AppRouter.router.push('/notifcationsScreen');

                            print("Notifications tapped");
                          },
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                JImages.notificationsvg,
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  isDark ? Colors.white : JAppColors.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              // Badge
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Profile
                        CircularAvatar(
                          isDark: isDark,
                          radius: 20,
                          imageUrl: JImages.image,
                        ),
                        const SizedBox(width: 12),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0 ,horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
              
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
              
                  SizedBox(height: 12,),
                  Row(
                    children: [
                      Text(
                        'recentPotJob',
                        style: AppTextStyle.dmSans(
                          fontSize: 16.0,
                          weight: FontWeight.w700,
                          color: isDark ? Colors.white : JAppColors.lightGray900,
                        ),
                      ).tr(),
                      Spacer(),
                      Text(
                        'viewAllRecent',
                        style: AppTextStyle.dmSans(
                          fontSize: 14.0,
                          weight: FontWeight.w500,
                          color: isDark ? Colors.white : JAppColors.lightGray900,
                        ),
                      ).tr(),
                    ],
                  ),
                  SizedBox(height: 12,),
              
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return JobCard(
                        isDark: isDark,
                        title: 'Electrician Needed',
                        location: 'United States',
                        workType: 'Hybrid',
                        salary: '\$20,000 - \$25,000',
                        category: 'Residential',
                        duration: '2 weeks',
                        skills: ['Plumber', 'Electrical'],
                        experience: '2+ Years',
                        postedAgo: '3 days ago',
                        onViewDetails: () {
                          // Handle navigation
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // Latest from Our Blog Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest from Our Blog',
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
                            AppRouter.router.push('/blogListScreen');

                          },
                          child: Text(
                            'Explore',
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

                  const SizedBox(height: 16),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      BlogCard(
                        isDark: isDark,
                        imageUrl: 'https://via.placeholder.com/400x200',
                        title: 'How Technology is Reshaping the Construction Industry',
                        description:
                        'Construction has always been about building the future. Today, that future is being transformed by digital tools and automation...',
                        tags: ['Tech', 'Innovation', 'Construction'],
                        onReadMore: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogDetailScreen(
                                imageUrl: "https://via.placeholder.com/400x200",
                                title: "How Technology is Reshaping the Construction Industry",
                                tags: ['Tech', 'Innovation', 'Construction'],
                              ),
                            ),
                          );

                          // Navigate to blog details
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Create your own Blog button
                  MainButton(
                    btn_title: 'Create your own Blog',
                    btn_radius: 10,
                    btn_color: JAppColors.primary,

                    title_color: Colors.white,
                    text_fontweight: FontWeight.w600,
                    image_value: false,
                    onTap: (){

                    }, isDark: isDark,
                  ),




                  const SizedBox(height: 24),

                  // Featured Ads Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Featured Ads',
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
                        child: Text(
                          'Create Ad',
                          style: AppTextStyle.dmSans(
                            fontSize: 12.0,
                            weight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Featured Ads
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 160,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage('https://via.placeholder.com/160x200'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(12),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              index == 0
                                  ? 'Plumber And Electrican Needed'
                                  : 'Plumber And Electrician Needed',
                              style: AppTextStyle.dmSans(
                                fontSize: 13.0,
                                weight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}