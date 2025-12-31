import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_contracts/utils/common_widgets/circular_avatar.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/jobs/job_list_item_model.dart';
import '../../../../utils/common_widgets/blog_card.dart';
import '../../../../utils/common_widgets/job_card.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../routes/app_routes.dart';
import '../blog/blog_detail_screen.dart';
import '../myads/create_ad_screen.dart';
import '../providers/ad_provider.dart';
import '../providers/job_provider.dart';
import 'bottom_sheet/FilterSelectionBottomSheet.dart';
import 'drawer/custom_navigation_drawer.dart';
import 'job_details/JobDetailScreen.dart';

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

    // Fetch jobs when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JobProvider>().fetchJobs(page: 1, limit: 10);
    });
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

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomNavigationDrawer(isDark: isDark),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? JAppColors.darkGray900 : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.1),
                  blurRadius: isDark ? 8 : 4,
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
                      fontSize: 18.0,
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
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                              fontSize: JSizes.fontSizeSm.toDouble(),
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

                const SizedBox(height: 12),
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
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Navigate to view all recent jobs
                      },
                      child: Text(
                        'viewAllRecent',
                        style: AppTextStyle.dmSans(
                          fontSize: 14.0,
                          weight: FontWeight.w500,
                          color: isDark ? Colors.white : JAppColors.lightGray900,
                        ),
                      ).tr(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Recently Posted Jobs Section with Provider
                Consumer<JobProvider>(
                  builder: (context, jobProvider, child) {
                    if (jobProvider.isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (jobProvider.errorMessage != null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                'Error loading jobs',
                                style: AppTextStyle.dmSans(
                                  fontSize: 14.0,
                                  weight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  jobProvider.fetchJobs(page: 1, limit: 10);
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final jobs = jobProvider.paginatedJobs?.jobs ?? [];

                    if (jobs.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            'No jobs available',
                            style: AppTextStyle.dmSans(
                              fontSize: 14.0,
                              weight: FontWeight.w400,
                              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                            ),
                          ),
                        ),
                      );
                    }

                    // Display first 4 jobs
                    final displayJobs = jobs.take(4).toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: displayJobs.length,
                      itemBuilder: (context, index) {
                        final job = displayJobs[index];

                        // Wrap in try-catch to identify the exact error
                        try {
                          return JobCard(
                            isDark: isDark,
                            title: job.title ?? 'No Title',
                            location: _getLocationString(job.jobLocation),
                            workType: job.jobType ?? 'N/A',
                            salary: job.salary ?? 'N/A',
                            category: job.jobCategory ?? 'N/A',
                            duration: job.jobDuration ?? 'N/A',
                            skills: job.skillsRequired.map((s) => s.name ?? '').toList(),
                            experience: job.experience ?? 'N/A',
                            postedAgo: _getTimeAgo(job.createdAt),
                            onViewDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetailScreen(
                                    jobId: job.id,
                                    jobData: {
                                      'title': job.title ?? 'Job Title',
                                      'description': job.description ?? 'No description available',
                                      'responsibilities': '' ?? [],
                                      'skillsRequired': job.skillsRequired.map((s) => s.name ?? '').toList(),
                                      'category': job.jobCategory ?? 'N/A',
                                      'duration': job.jobDuration ?? 'N/A',
                                      'experience': job.experience ?? 'N/A',
                                      'salary': job.salary ?? 'N/A',
                                      'workType': job.jobType ?? 'N/A',
                                      'location': _getLocationString(job.jobLocation),
                                      'clientHistory': '' ?? [],
                                      'isSaved': true ?? false,
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        } catch (e) {
                          // Fallback card to show error details
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.red),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Error loading job card',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Error: $e',
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Job Title: ${job.title}',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
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
                        onTap: () {
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
                              title:
                              "How Technology is Reshaping the Construction Industry",
                              tags: ['Tech', 'Innovation', 'Construction'],
                            ),
                          ),
                        );
                      },
                    ),
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
                              title:
                              "How Technology is Reshaping the Construction Industry",
                              tags: ['Tech', 'Innovation', 'Construction'],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Create your own Blog button
                MainButton(
                  btn_title: 'Create your own Blog',
                  btn_radius: 10.0,
                  btn_color: JAppColors.primary,
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  onTap: () {},
                  isDark: isDark,
                ),

                const SizedBox(height: 24),


                // Featured Ads
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
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAdScreen(),));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    ),
                  ],
                ),

                const SizedBox(height: 16),

// Featured Ads with Provider
                Consumer<AdProvider>(
                  builder: (context, adProvider, child) {
                    // Fetch ads on first build
                    if (adProvider.ads.isEmpty && !adProvider.isLoading) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        adProvider.fetchAds(page: 1, limit: 10);
                      });
                    }

                    if (adProvider.isLoading) {
                      return const SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (adProvider.errorMessage != null) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Error loading ads',
                                style: AppTextStyle.dmSans(
                                  fontSize: 14.0,
                                  weight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  adProvider.fetchAds(page: 1, limit: 10);
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final ads = adProvider.ads;

                    if (ads.isEmpty) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Text(
                            'No ads available',
                            style: AppTextStyle.dmSans(
                              fontSize: 14.0,
                              weight: FontWeight.w400,
                              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                            ),
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: ads.length,
                        itemBuilder: (context, index) {
                          final ad = ads[index];

                          return Container(
                            width: 160,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: ad.image.isNotEmpty
                                    ? NetworkImage(ad.image)
                                    : const NetworkImage('https://via.placeholder.com/160x200'),
                                fit: BoxFit.cover,
                                onError: (exception, stackTrace) {
                                  // Fallback if image fails to load
                                },
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    ad.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle.dmSans(
                                      fontSize: 13.0,
                                      weight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${ad.price}',
                                    style: AppTextStyle.dmSans(
                                      fontSize: 12.0,
                                      weight: FontWeight.w500,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to get location string from coordinates
  String _getLocationString(JobLocation location) {
    if (location.coordinates.isNotEmpty) {
      return 'Lat: ${location.coordinates[1].toStringAsFixed(2)}, Lng: ${location.coordinates[0].toStringAsFixed(2)}';
    }
    return 'Location not available';
  }

  // Helper method to calculate time ago from createdAt timestamp
  String _getTimeAgo(String createdAt) {
    try {
      final dateTime = DateTime.parse(createdAt);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 365) {
        final years = (difference.inDays / 365).floor();
        return '$years ${years == 1 ? 'year' : 'years'} ago';
      } else if (difference.inDays > 30) {
        final months = (difference.inDays / 30).floor();
        return '$months ${months == 1 ? 'month' : 'months'} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Recently';
    }
  }
}



// import 'package:easy_localization/easy_localization.dart';
// import 'package:easy_localization/easy_localization.dart' as easy;
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:job_contracts/utils/common_widgets/circular_avatar.dart';
// import 'package:job_contracts/utils/constants/colors.dart';
// import 'package:job_contracts/utils/constants/image_string.dart';
// import 'package:job_contracts/utils/constants/sizes.dart';
// import 'package:job_contracts/utils/device/device_utility.dart';
// import '../../../../utils/common_widgets/blog_card.dart';
// import '../../../../utils/common_widgets/job_card.dart';
// import '../../../../utils/common_widgets/main_button.dart';
// import '../../../../utils/constants/app_text_style.dart';
// import '../../../routes/app_routes.dart';
// import '../blog/blog_detail_screen.dart';
// import 'bottom_sheet/FilterSelectionBottomSheet.dart';
// import 'drawer/custom_navigation_drawer.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   Map<String, List<String>> selectedFilters = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   void updateFilters(Map<String, List<String>> newFilters) {
//     setState(() {
//       selectedFilters = newFilters;
//     });
//     print('Applied filters: $selectedFilters');
//   }
//
//   void showFilterBottomSheet() async {
//     final result = await FilterSelectionBottomSheet.show(
//       context,
//       initialFilters: selectedFilters,
//     );
//
//     if (result != null) {
//       updateFilters(result);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//
//     return SafeArea(
//
//       child: Scaffold(
//         key: _scaffoldKey,
//         drawer: CustomNavigationDrawer(isDark: isDark),
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(60),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: isDark ? JAppColors.darkGray900 : Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: isDark
//                       ? Colors.black.withValues(alpha: 0.3)  // 3x stronger for dark mode
//                       : Colors.black.withValues(alpha: 0.1),
//                   blurRadius: isDark ? 8 : 4,  // Larger blur radius in dark mode
//                   offset: const Offset(0, 2),
//                 ),
//               ],            ),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Left: Drawer icon
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: GestureDetector(
//                     onTap: () => _scaffoldKey.currentState?.openDrawer(),
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       child: SvgPicture.asset(
//                         JImages.drawer,
//                         colorFilter: ColorFilter.mode(
//                           isDark ? Colors.white : JAppColors.primary,
//                           BlendMode.srcIn,
//                         ),
//                         height: 24,
//                         width: 24,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Center: Title
//                 Padding(
//                   padding: const EdgeInsets.only(right: 24),
//                   child: Text(
//                     "Home",
//                     style: TextStyle(
//                       color: isDark ? Colors.white : Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//
//                 // Right: Notification + Profile
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Notification Icon
//                       GestureDetector(
//                         onTap: () {
//                           AppRouter.router.push('/notifcationsScreen');
//
//                           print("Notifications tapped");
//                         },
//                         child: Stack(
//                           children: [
//                             SvgPicture.asset(
//                               JImages.notificationsvg,
//                               height: 24,
//                               width: 24,
//                               colorFilter: ColorFilter.mode(
//                                 isDark ? Colors.white : JAppColors.primary,
//                                 BlendMode.srcIn,
//                               ),
//                             ),
//                             // Badge
//                             Positioned(
//                               right: 0,
//                               top: 0,
//                               child: Container(
//                                 width: 8,
//                                 height: 8,
//                                 decoration: const BoxDecoration(
//                                   color: Colors.red,
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//
//                       // Profile
//                       CircularAvatar(
//                         isDark: isDark,
//                         radius: 20,
//                         imageUrl: JImages.image,
//                       ),
//                       const SizedBox(width: 12),
//
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16.0 ,horizontal: 16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//
//                 GestureDetector(
//                   onTap: () {
//                     // Navigate to full search screen
//                   },
//                   child: Container(
//                     height: 52,
//
//                     decoration: BoxDecoration(
//                       color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                     child: Row(
//                       children: [
//                         SvgPicture.asset(
//                           JImages.search,
//                           width: 18,
//                           height: 18,
//                           colorFilter: ColorFilter.mode(
//                             isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//                             BlendMode.srcIn,
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Text(
//                             easy.tr('searchJob'),
//                             style: AppTextStyle.dmSans(
//                               fontSize: JSizes.fontSizeSm,
//                               weight: FontWeight.w400,
//                               color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         GestureDetector(
//                           onTap: () => showFilterBottomSheet(),
//                           child: SvgPicture.asset(
//                             JImages.filters,
//                             width: 18,
//                             height: 18,
//                             colorFilter: ColorFilter.mode(
//                               isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//                               BlendMode.srcIn,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 12,),
//                 Row(
//                   children: [
//                     Text(
//                       'recentPotJob',
//                       style: AppTextStyle.dmSans(
//                         fontSize: 16.0,
//                         weight: FontWeight.w700,
//                         color: isDark ? Colors.white : JAppColors.lightGray900,
//                       ),
//                     ).tr(),
//                     Spacer(),
//                     Text(
//                       'viewAllRecent',
//                       style: AppTextStyle.dmSans(
//                         fontSize: 14.0,
//                         weight: FontWeight.w500,
//                         color: isDark ? Colors.white : JAppColors.lightGray900,
//                       ),
//                     ).tr(),
//                   ],
//                 ),
//                 SizedBox(height: 12,),
//
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: 4,
//                   itemBuilder: (context, index) {
//                     return JobCard(
//                       isDark: isDark,
//                       title: 'Electrician Needed',
//                       location: 'United States',
//                       workType: 'Hybrid',
//                       salary: '\$20,000 - \$25,000',
//                       category: 'Residential',
//                       duration: '2 weeks',
//                       skills: ['Plumber', 'Electrical'],
//                       experience: '2+ Years',
//                       postedAgo: '3 days ago',
//                       onViewDetails: () {
//                         AppRouter.router.push('/jobDetailScreen');
//
//                         // ContractDetailScreen
//                         // Handle navigation
//                       },
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 12),
//
//                 // Latest from Our Blog Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Latest from Our Blog',
//                       style: AppTextStyle.dmSans(
//                         fontSize: 18.0,
//                         weight: FontWeight.w700,
//                         color: isDark
//                             ? JAppColors.darkGray100
//                             : JAppColors.darkGray800,
//                       ),
//                     ),
//                     Container(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: JAppColors.primary,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: GestureDetector(
//                         onTap: (){
//                           AppRouter.router.push('/blogListScreen');
//
//                         },
//                         child: Text(
//                           'Explore',
//                           style: AppTextStyle.dmSans(
//                             fontSize: 12.0,
//                             weight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 16),
//                 ListView(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: [
//                     BlogCard(
//                       isDark: isDark,
//                       imageUrl: 'https://via.placeholder.com/400x200',
//                       title: 'How Technology is Reshaping the Construction Industry',
//                       description:
//                       'Construction has always been about building the future. Today, that future is being transformed by digital tools and automation...',
//                       tags: ['Tech', 'Innovation', 'Construction'],
//                       onReadMore: () {
//
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => BlogDetailScreen(
//                               imageUrl: "https://via.placeholder.com/400x200",
//                               title: "How Technology is Reshaping the Construction Industry",
//                               tags: ['Tech', 'Innovation', 'Construction'],
//                             ),
//                           ),
//                         );
//
//                         // Navigate to blog details
//                       },
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // Create your own Blog button
//                 MainButton(
//                   btn_title: 'Create your own Blog',
//                   btn_radius: 10,
//                   btn_color: JAppColors.primary,
//
//                   title_color: Colors.white,
//                   text_fontweight: FontWeight.w600,
//                   image_value: false,
//                   onTap: (){
//
//                   }, isDark: isDark,
//                 ),
//
//
//
//
//                 const SizedBox(height: 24),
//
//                 // Featured Ads Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Featured Ads',
//                       style: AppTextStyle.dmSans(
//                         fontSize: 18.0,
//                         weight: FontWeight.w700,
//                         color: isDark
//                             ? JAppColors.darkGray100
//                             : JAppColors.darkGray800,
//                       ),
//                     ),
//                     Container(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: JAppColors.primary,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         'Create Ad',
//                         style: AppTextStyle.dmSans(
//                           fontSize: 12.0,
//                           weight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // Featured Ads
//                 SizedBox(
//                   height: 200,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     itemCount: 3,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         width: 160,
//                         margin: const EdgeInsets.only(right: 12),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           image: DecorationImage(
//                             image: NetworkImage('https://via.placeholder.com/160x200'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 Colors.transparent,
//                                 Colors.black.withOpacity(0.7),
//                               ],
//                             ),
//                           ),
//                           padding: const EdgeInsets.all(12),
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             index == 0
//                                 ? 'Plumber And Electrican Needed'
//                                 : 'Plumber And Electrician Needed',
//                             style: AppTextStyle.dmSans(
//                               fontSize: 13.0,
//                               weight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//
//                 const SizedBox(height: 24),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
