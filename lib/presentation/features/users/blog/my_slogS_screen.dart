import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
import '../../../../data/data_source/local/AuthPreferences.dart';
// ✅ Removed duplicate: '../providers/BlogProvider.dart'
import '../../../../data/models/blog/BlogModel.dart';
import '../providers/BlogProvider.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await AuthPreferences.getUser();
      if (user != null && context.mounted) {
        context.read<BlogProvider>().fetchMyBlogs(user.id);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    final user = await AuthPreferences.getUser();
    if (user != null && context.mounted) {
      await context.read<BlogProvider>().fetchMyBlogs(user.id);
    }
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
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircularAvatar(
              isDark: isDark,
              radius: 18,
              imageUrl: JImages.image,
            ),
          ),
        ],
      ),

      body: Consumer<BlogProvider>(
        builder: (context, blogProvider, _) {
          final allBlogs = blogProvider.myBlogs;
          final publishedBlogs = allBlogs;
          final draftBlogs = <BlogModel>[];

          return Column(
            children: [
              // ── Header ────────────────────────────────────────────────────
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
                    ),
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
                        await context.push('/blogCreateScreen');
                        if (context.mounted) _refresh();
                      },
                      text_size: 14,
                    ),
                  ],
                ),
              ),

              // ── Tab Bar ───────────────────────────────────────────────────
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
                      Tab(text: 'All (${allBlogs.length})'),
                      Tab(text: 'Published (${publishedBlogs.length})'),
                      Tab(text: 'Drafts (${draftBlogs.length})'),
                    ],
                  ),
                ),
              ),

              // ── Tab Content ───────────────────────────────────────────────
              Expanded(
                child: blogProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : blogProvider.errorMessage != null
                    ? _buildErrorWidget(
                  isDark,
                  blogProvider.errorMessage!,
                  blogProvider,
                )
                    : TabBarView(
                  controller: _tabController,
                  children: [
                    allBlogs.isEmpty
                        ? EmptyStateWidget(
                      message: 'No blog posts yet',
                      isDark: isDark,
                      icon: Icons.article_outlined,
                    )
                        : _buildBlogList(isDark, allBlogs, blogProvider),
                    publishedBlogs.isEmpty
                        ? EmptyStateWidget(
                      message: 'No published posts',
                      isDark: isDark,
                      icon: Icons.publish_outlined,
                    )
                        : _buildBlogList(isDark, publishedBlogs, blogProvider),
                    EmptyStateWidget(
                      message: 'No draft posts',
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

  Widget _buildBlogList(
      bool isDark,
      List<BlogModel> blogs,
      BlogProvider blogProvider,
      ) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];

          // ✅ createdAt is non-nullable String — no null check needed
          String createdDate = '';
          try {
            createdDate = blog.createdAt.isNotEmpty
                ? DateFormat('MMM yyyy').format(DateTime.parse(blog.createdAt))
                : '';
          } catch (_) {
            createdDate = '';
          }

          return BlogCardWidget(
            title: blog.title,
            createdBy: 'Created By',
            createdDate: createdDate,
            publishedDate: createdDate,
            tags: blog.tags,
            isDark: isDark,
            onEdit: () => context.push('/blogCreateScreen'),
            onDelete: () =>
                _showDeleteDialog(context, isDark, blog.id, blogProvider),
          );
        },
      ),
    );
  }

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
                color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _refresh,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context,
      bool isDark,
      String blogId,
      BlogProvider blogProvider,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              onPressed: () => Navigator.pop(ctx),
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
                Navigator.pop(ctx);
                // blogProvider.removeMyBlogByIdogById(blogId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Blog post deleted')),
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