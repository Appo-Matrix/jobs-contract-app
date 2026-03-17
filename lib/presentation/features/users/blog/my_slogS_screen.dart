import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contract_app/presentation/features/users/blog/provider/blog_provider.dart';
import 'package:job_contract_app/presentation/features/users/blog/widgets/EmptyStateWidget.dart';
import 'package:job_contract_app/presentation/features/users/blog/widgets/blog_card_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../routes/app_routes.dart';
import 'model/blog_model.dart';


class MyBlogScreen extends StatefulWidget {
  const MyBlogScreen({super.key});

  @override
  State<MyBlogScreen> createState() => _MyBlogScreenState();
}

class _MyBlogScreenState extends State<MyBlogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // ✅ Load the current user's blogs when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BlogProvider>().loadMyBlogs();
    });
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
      appBar: JAppbar(
        leadingIcon: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
              size: 24,
            ),
          ),
        ),
        title: Text(
          'My Blog',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
          ),
        ).tr(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircularAvatar(
              isDark: isDark,
              radius: 18,
              imageUrl: JImages.image,
            ),
          )
        ],
      ),

      // ✅ Wrap entire body in Consumer to react to BlogProvider changes
      body: Consumer<BlogProvider>(
        builder: (context, blogProvider, _) {
          final allBlogs = blogProvider.myBlogs;

          // Treat all fetched blogs as published for now.
          // Extend BlogModel with a 'status' field if drafts are needed later.
          final publishedBlogs = allBlogs;
          final draftBlogs = <BlogModel>[];

          final allCount = allBlogs.length;
          final publishedCount = publishedBlogs.length;
          final draftCount = draftBlogs.length;

          return Column(
            children: [
              // ── Header: title + create button ──────────────────────────────
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Blog Posts',
                      style: AppTextStyle.dmSans(
                        fontSize: 18.0,
                        weight: FontWeight.w600,
                        color: isDark
                            ? JAppColors.darkGray100
                            : JAppColors.darkGray900,
                      ),
                    ).tr(),
                    MainButton(
                      btn_title: "Create New Blog",
                      btn_radius: 8,
                      height: 40,
                      width: 160,
                      buttonType: MainButtonType.primary,
                      btn_color: JAppColors.primary,
                      title_color: JAppColors.darkGray100,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                      onTap: () async {
                        // ✅ After returning from create screen, refresh my blogs
                        await AppRouter.router.push('/blogCreateScreen');
                        if (context.mounted) {
                          context.read<BlogProvider>().loadMyBlogs();
                        }
                      },
                      text_size: 14,
                    ),
                  ],
                ),
              ),

              // ── Tab bar ────────────────────────────────────────────────────
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 35,
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
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
                    unselectedLabelColor: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray800,
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
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.lightGray800,
                    ),
                    tabs: [
                      Tab(text: 'All'.tr(args: [allCount.toString()])),
                      Tab(
                        text: 'Published'
                            .tr(args: [publishedCount.toString()]),
                      ),
                      Tab(
                        text: 'Drafts'.tr(args: [draftCount.toString()]),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Tab content ────────────────────────────────────────────────
              Expanded(
                child: blogProvider.isLoadingMyBlogs
                // Loading state
                    ? const Center(child: CircularProgressIndicator())

                // Error state
                    : blogProvider.myBlogsError != null
                    ? _buildErrorWidget(
                  isDark,
                  blogProvider.myBlogsError!,
                  blogProvider,
                )

                // Data state
                    : TabBarView(
                  controller: _tabController,
                  children: [
                    // All tab
                    allBlogs.isEmpty
                        ? EmptyStateWidget(
                      message: 'no_blog_posts'.tr(),
                      isDark: isDark,
                      icon: Icons.article_outlined,
                    )
                        : _buildBlogList(
                        isDark, allBlogs, blogProvider),

                    // Published tab
                    publishedBlogs.isEmpty
                        ? EmptyStateWidget(
                      message: 'no_published_posts'.tr(),
                      isDark: isDark,
                      icon: Icons.drafts_outlined,
                    )
                        : _buildBlogList(
                        isDark, publishedBlogs, blogProvider),

                    // Drafts tab
                    EmptyStateWidget(
                      message: 'no_draft_posts'.tr(),
                      isDark: isDark,
                      icon: Icons.drafts_outlined,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Blog list with pull-to-refresh ────────────────────────────────────────

  Widget _buildBlogList(
      bool isDark,
      List<BlogModel> blogs,
      BlogProvider blogProvider,
      ) {
    return RefreshIndicator(
      onRefresh: () => blogProvider.loadMyBlogs(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];

          // ✅ Format createdAt date from BlogModel
          final createdDate = blog.createdAt != null
              ? DateFormat('MMM yyyy').format(blog.createdAt!)
              : '';

          return BlogCardWidget(
            title: blog.title,
            createdBy: 'Created By',
            createdDate: createdDate,
            publishedDate: createdDate,
            tags: blog.tags,
            isDark: isDark,
            onEdit: () {
              AppRouter.router.push('/blogCreateScreen');
            },
            onDelete: () {
              _showDeleteDialog(context, isDark, blog.id, blogProvider);
            },
          );
        },
      ),
    );
  }

  // ── Error widget with retry ───────────────────────────────────────────────

  Widget _buildErrorWidget(
      bool isDark,
      String error,
      BlogProvider blogProvider,
      ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: JAppColors.error500),
            const SizedBox(height: 16),
            Text(
              error,
              textAlign: TextAlign.center,
              style: AppTextStyle.dmSans(
                fontSize: 14.0,
                weight: FontWeight.w400,
                color:
                isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
              ),
            ),
            const SizedBox(height: 24),
            MainButton(
              btn_title: "Retry",
              btn_radius: 8,
              height: 44,
              width: 120,
              buttonType: MainButtonType.primary,
              btn_color: JAppColors.primary,
              title_color: Colors.white,
              text_fontweight: FontWeight.w600,
              image_value: false,
              onTap: () => blogProvider.loadMyBlogs(),
              text_size: 14,
            ),
          ],
        ),
      ),
    );
  }

  // ── Delete confirmation dialog ────────────────────────────────────────────

  void _showDeleteDialog(
      BuildContext context,
      bool isDark,
      String blogId,
      BlogProvider blogProvider,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Delete Blog Post',
            style: AppTextStyle.dmSans(
              fontSize: 18.0,
              weight: FontWeight.w600,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this blog post? This action cannot be undone.',
            style: AppTextStyle.dmSans(
              fontSize: 14.0,
              weight: FontWeight.w400,
              color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  weight: FontWeight.w500,
                  color:
                  isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
                ),
              ),
            ),
            MainButton(
              btn_title: "Delete",
              btn_radius: 8,
              height: 36,
              width: 80,
              buttonType: MainButtonType.primary,
              btn_color: JAppColors.error500,
              title_color: Colors.white,
              text_fontweight: FontWeight.w600,
              image_value: false,
              onTap: () {
                Navigator.pop(context);
                // ✅ Optimistic remove from local list immediately
                blogProvider.removeMyBlogById(blogId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Blog post deleted successfully'),
                  ),
                );
              },
              text_size: 14,
            ),
          ],
        );
      },
    );
  }
}


// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:job_contract_client/presentation/features/dashboard/blog/widgets/EmptyStateWidget.dart';
// import 'package:job_contract_client/presentation/features/dashboard/blog/widgets/blog_card_widget.dart';
// import '../../../../../utils/common_widgets/appbar.dart';
// import '../../../../../utils/common_widgets/circular_avatar.dart';
// import '../../../../../utils/common_widgets/main_button.dart';
// import '../../../../../utils/constants/app_text_style.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/image_string.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/device/device_utility.dart';
// import '../../../routes/app_routes.dart';
//
// class MyBlogScreen extends StatefulWidget {
//   const MyBlogScreen({super.key});
//
//   @override
//   State<MyBlogScreen> createState() => _MyBlogScreenState();
// }
//
// class _MyBlogScreenState extends State<MyBlogScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
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
//   int allCount = 2;
//   int publishedCount = 0;
//   int draftCount = 0;
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       appBar: JAppbar(
//         leadingIcon: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Icon(
//               Icons.arrow_back,
//               color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
//               size: 24,
//             ),
//           ),
//         ),
//         title: Text(
//           'my_blog_title',
//           style: AppTextStyle.dmSans(
//             fontSize: 18.0,
//             weight: FontWeight.w600,
//             color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
//           ),
//         ).tr(),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 12),
//             child: CircularAvatar(
//               isDark: isDark,
//               radius: 18,
//               imageUrl: JImages.image,
//             ),
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           // Header section with title and button
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'your_blog_posts',
//                   style: AppTextStyle.dmSans(
//                     fontSize: 18.0,
//                     weight: FontWeight.w600,
//                     color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
//                   ),
//                 ).tr(),
//                 MainButton(
//                   btn_title: "create_new_blog_button",
//                   btn_radius: 8,
//                   height: 40,
//                   width: 160,
//                   buttonType: MainButtonType.primary,
//                   btn_color: JAppColors.primary,
//                   title_color: JAppColors.darkGray100,
//                   text_fontweight: FontWeight.w600,
//                   image_value: false,
//                   onTap: () {
//                     AppRouter.router.push('/blogCreateScreen');
//                   },
//                   text_size: 14,
//                 ),
//               ],
//             ),
//           ),
//
//           // Tabs
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               height: 35,
//               margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
//               child: TabBar(
//                 dividerColor: Colors.transparent,
//                 controller: _tabController,
//                 isScrollable: true,
//                 tabAlignment: TabAlignment.start,
//                 indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: JAppColors.primary,
//                 ),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                 padding: const EdgeInsets.all(3),
//                 indicatorWeight: 0,
//                 labelStyle: AppTextStyle.dmSans(
//                   fontSize: JSizes.fontSizeESm,
//                   weight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//                 unselectedLabelStyle: AppTextStyle.dmSans(
//                   fontSize: JSizes.fontSizeESm,
//                   weight: FontWeight.w500,
//                   color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
//                 ),
//                 tabs:  [
//                   Tab(text: 'tab_all'.tr(args: [allCount.toString()])),
//                   Tab(text: 'tab_published'.tr(args: [publishedCount.toString()])),
//                   Tab(text: 'tab_drafts'.tr(args: [draftCount.toString()])),
//
//                 ],
//               ),
//             ),
//           ),
//
//           // Blog posts list
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 // All tab
//                 _buildBlogList(isDark, 2),
//                 // Published tab
//
//
//                 EmptyStateWidget(
//                   message: 'no_published_posts'.tr(),
//                   isDark: isDark,
//                   icon: Icons.drafts_outlined,
//                 )
//                 ,
//                 // Drafts tab
//                 EmptyStateWidget(
//                   message: 'no_draft_posts'.tr(),
//                   isDark: isDark,
//                   icon: Icons.drafts_outlined,
//                 )
//
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _buildBlogList(bool isDark, int itemCount) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: itemCount,
//       itemBuilder: (context, index) {
//         return BlogCardWidget(
//           title: 'Plumber And Electrician Needed',
//           createdBy: 'Created By',
//           createdDate: 'Aug2025',
//           publishedDate: 'Sep 2025',
//           tags: ['Plumber', 'Electrical'],
//           isDark: isDark,
//           onEdit: () {
//             // Navigate to edit screen
//           },
//           onDelete: () {
//             _showDeleteDialog(context, isDark);
//           },
//         );
//       },
//     );
//   }
//
//
//
//
//
//   void _showDeleteDialog(BuildContext context, bool isDark) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: Text(
//             'Delete Blog Post',
//             style: AppTextStyle.dmSans(
//               fontSize: 18.0,
//               weight: FontWeight.w600,
//               color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
//             ),
//           ),
//           content: Text(
//             'Are you sure you want to delete this blog post? This action cannot be undone.',
//             style: AppTextStyle.dmSans(
//               fontSize: 14.0,
//               weight: FontWeight.w400,
//               color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 'Cancel',
//                 style: AppTextStyle.dmSans(
//                   fontSize: 14.0,
//                   weight: FontWeight.w500,
//                   color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
//                 ),
//               ),
//             ),
//             MainButton(
//               btn_title: "Delete",
//               btn_radius: 8,
//               height: 36,
//               width: 80,
//               buttonType: MainButtonType.primary,
//               btn_color: JAppColors.error500,
//               title_color: Colors.white,
//               text_fontweight: FontWeight.w600,
//               image_value: false,
//               onTap: () {
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Blog post deleted successfully'),
//                   ),
//                 );
//               },
//               text_size: 14,
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
