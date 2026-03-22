import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_contract_app/presentation/routes/routes.dart';

import 'package:provider/provider.dart';
import '../../../../data/models/jobs/job_list_item_model.dart';
import '../../../../utils/common_widgets/blog_card.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/common_widgets/job_card.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../routes/app_routes.dart';
import '../account_screen/provider/recent_job_provider.dart';
import '../blog/blog_detail_screen.dart';
import '../jobs/view_all_jobs_screen.dart';
import '../myads/create_ad_screen.dart';
import '../providers/BlogProvider.dart' show BlogProvider;
import '../providers/ad_provider.dart';
import '../providers/job_provider.dart';
import '../../../../data/models/blog/BlogModel.dart';
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

    // Fetch latest jobs sorted by createdAt descending
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JobProvider>().fetchJobs(
        sortBy: 'createdAt',
        sortOrder: 'desc',
      );

      // ✅ Fetch ads once here — NOT inside Consumer build
      context.read<AdProvider>().fetchAds(page: 1, limit: 10);

      // ✅ Fetch blogs once here
      context.read<BlogProvider>().fetchBlogs();
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
                // ── Search Bar ──────────────────────────────────────────────
                GestureDetector(
                  onTap: () {},
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
                              fontSize: JSizes.fontSizeSm.toDouble(),
                              weight: FontWeight.w400,
                              color: isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.lightGray500,
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
                              isDark
                                  ? JAppColors.lightGray100
                                  : JAppColors.darkGray800,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ── Section Header: Latest Jobs ─────────────────────────────
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: JAppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewAllJobsScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'View All Recent',
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

                const SizedBox(height: 12),

                // ── Latest Jobs List from JobProvider ───────────────────────
                Consumer<JobProvider>(
                  builder: (context, jobProvider, child) {
                    // ── Loading ──
                    if (jobProvider.isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    // ── Error ──
                    if (jobProvider.errorMessage != null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                'Internet Issue',
                                style: AppTextStyle.dmSans(
                                  fontSize: 14.0,
                                  weight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => jobProvider.fetchJobs(
                                  sortBy: 'createdAt',
                                  sortOrder: 'desc',
                                ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // ── Jobs already sorted desc by createdAt from provider ──
                    final allJobs = jobProvider.paginatedJobs?.jobs ?? [];

                    if (allJobs.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            'No jobs available',
                            style: AppTextStyle.dmSans(
                              fontSize: 14.0,
                              weight: FontWeight.w400,
                              color: isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.lightGray500,
                            ),
                          ),
                        ),
                      );
                    }

                    // ── Show latest 5 jobs (already sorted desc) ────────────
                    final displayJobs = allJobs.take(5).toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: displayJobs.length,
                      itemBuilder: (context, index) {
                        final job = displayJobs[index];

                        try {
                          return JobCard(
                            isDark: isDark,
                            title: job.title,
                            location: _getLocationString(job.jobLocation),
                            workType: job.jobType,
                            salary: job.salary,
                            category: job.jobCategory,
                            duration: job.jobDuration,
                            skills: job.skillsRequired
                                .map((s) => s.name)
                                .toList(),
                            experience: job.experience,
                            postedAgo: _getTimeAgo(job.createdAt),
                            onViewDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetailScreen(
                                    jobId: job.id,
                                    jobData: {
                                      'title': job.title,
                                      'description': job.description,
                                      'responsibilities': '',
                                      'skillsRequired': job.skillsRequired
                                          .map((s) => s.name)
                                          .toList(),
                                      'category': job.jobCategory,
                                      'duration': job.jobDuration,
                                      'experience': job.experience,
                                      'salary': job.salary,
                                      'workType': job.jobType,
                                      'location':
                                      _getLocationString(job.jobLocation),
                                      'clientHistory': '',
                                      'isSaved': false,
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        } catch (e) {
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
                                const Text(
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
                                Text(
                                  'Job Title: ${job.title}',
                                  style: const TextStyle(fontSize: 12.0),
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

                // ── Blog Section ────────────────────────────────────────────
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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

                // ── Blog List from BlogProvider ─────────────────────────────
                Consumer<BlogProvider>(
                  builder: (context, blogProvider, child) {
                    if (blogProvider.isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (blogProvider.errorMessage != null) {
                      return Center(
                        child: Column(
                          children: [
                            Text(
                              'Failed to load blogs',
                              style: AppTextStyle.dmSans(
                                fontSize: 14.0,
                                weight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => blogProvider.fetchBlogs(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (blogProvider.blogs.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            'No blogs available',
                            style: AppTextStyle.dmSans(
                              fontSize: 14.0,
                              weight: FontWeight.w400,
                              color: isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.lightGray500,
                            ),
                          ),
                        ),
                      );
                    }

                    final displayBlogs = blogProvider.blogs.take(3).toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: displayBlogs.length,
                      itemBuilder: (context, index) {
                        final blog = displayBlogs[index];
                        return BlogCard(
                          isDark: isDark,
                          imageUrl: blog.image.isNotEmpty
                              ? blog.image
                              : 'https://via.placeholder.com/400x200',
                          title: blog.title,
                          description: blog.content.length > 100
                              ? '${blog.content.substring(0, 100)}...'
                              : blog.content,
                          tags: blog.tags,
                          onReadMore: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlogDetailScreen(
                                  imageUrl: blog.image.isNotEmpty
                                      ? blog.image
                                      : 'https://via.placeholder.com/400x200',
                                  title: blog.title,
                                  tags: blog.tags,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 16),

                MainButton(
                  btn_title: 'Create your own Blog',
                  btn_radius: 10.0,
                  btn_color: JAppColors.primary,
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  onTap: () {

                    AppRouter.router.goNamed(Routes.myBlogScreen.name);

                  },
                  isDark: isDark,
                ),

                const SizedBox(height: 24),

                // ── Featured Ads Section ────────────────────────────────────
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAdScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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

                Consumer<AdProvider>(
                  builder: (context, adProvider, child) {
                    // ✅ No fetchAds here — called once in initState above

                    if (adProvider.isLoading) {
                      return const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
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
                                onPressed: () =>
                                    adProvider.fetchAds(page: 1, limit: 10),
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
                              color: isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.lightGray500,
                            ),
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
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
                                    : const NetworkImage(
                                    'https://via.placeholder.com/160x200'),
                                fit: BoxFit.cover,
                                onError: (exception, stackTrace) {},
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

  // ── Helper: human-readable location ────────────────────────────────────────
  // Uses city field if available, falls back to country, then coordinates
  String _getLocationString(JobLocation location) {
    if (location.coordinates.length >= 2) {
      final lat = location.coordinates[1].toStringAsFixed(4);
      final lng = location.coordinates[0].toStringAsFixed(4);
      return 'Lat: $lat, Lng: $lng';
    }
    return 'Location not available';
  }

  // ── Helper: relative time string ────────────────────────────────────────────
  String _getTimeAgo(String createdAt) {
    try {
      final dateTime = DateTime.parse(createdAt);
      final difference = DateTime.now().difference(dateTime);

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
    } catch (_) {
      return 'Recently';
    }
  }
}