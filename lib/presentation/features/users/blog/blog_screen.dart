import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:job_contract_app/presentation/features/users/blog/provider/blog_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/blog_card.dart';
import '../../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

import '../../../routes/app_routes.dart';
import 'blog_detail_screen.dart';
import 'model/blog_model.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ Fetch all blogs when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BlogProvider>().loadBlogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'blogs'.tr(),
            style: AppTextStyle.dmSans(
              fontSize: 18.0,
              weight: FontWeight.w600,
              color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
            ),
          ).tr(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircularAvatar(
              isDark: isDark,
              radius: 18,
              imageUrl: JImages.image,
            ),
          ),
        ],
      ),

      // ✅ Body scrolls, button stays fixed
      body: Consumer<BlogProvider>(
        builder: (context, blogProvider, _) {
          // ── Loading state ──────────────────────────────────────────────────
          if (blogProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ── Error state ────────────────────────────────────────────────────
          if (blogProvider.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: JAppColors.error500,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      blogProvider.errorMessage!,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.dmSans(
                        fontSize: 14.0,
                        weight: FontWeight.w400,
                        color: isDark
                            ? JAppColors.darkGray300
                            : JAppColors.darkGray700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    MainButton(
                      btn_title: "Retry",
                      btn_radius: 6,
                      height: 44,
                      width: 120,
                      buttonType: MainButtonType.primary,
                      title_color: Colors.white,
                      text_fontweight: FontWeight.w600,
                      image_value: false,
                      onTap: () => blogProvider.loadBlogs(),
                      text_size: JSizes.fontSizeMd,
                    ),
                  ],
                ),
              ),
            );
          }

          // ── Empty state ────────────────────────────────────────────────────
          if (blogProvider.blogs.isEmpty) {
            return Center(
              child: Text(
                'No blogs found',
                style: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  weight: FontWeight.w400,
                  color: isDark
                      ? JAppColors.darkGray300
                      : JAppColors.darkGray700,
                ),
              ),
            );
          }

          // ── Data state ─────────────────────────────────────────────────────
          final blogs = blogProvider.blogs;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: RefreshIndicator(
              // ✅ Pull-to-refresh
              onRefresh: () => blogProvider.loadBlogs(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: blogs.length,
                      itemBuilder: (context, index) {
                        final BlogModel blog = blogs[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: BlogCard(
                            isDark: isDark,
                            // ✅ Use imageUrl from API, fallback to placeholder
                            imageUrl: blog.imageUrl != null &&
                                blog.imageUrl!.isNotEmpty
                                ? blog.imageUrl!
                                : 'https://images.unsplash.com/photo-1503387762-592deb58ef4e?w=800',
                            title: blog.title,
                            description: blog.content.length > 120
                                ? '${blog.content.substring(0, 120)}...'
                                : blog.content,
                            tags: blog.tags,
                            onReadMore: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlogDetailScreen(
                                    imageUrl: blog.imageUrl ??
                                        'https://via.placeholder.com/400x200',
                                    title: blog.title,
                                    tags: blog.tags,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: MainButton(
                btn_title: "My Blog",
                btn_radius: 6,
                height: 46,
                buttonType: MainButtonType.primary,
                title_color: JAppColors.darkGray100,
                text_fontweight: FontWeight.w500,
                image_value: false,
                onTap: () {
                  AppRouter.router.push('/myBlogScreen');
                },
                text_size: JSizes.fontSizeMd,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: MainButton(
                btn_title: "Create Blog",
                btn_radius: 6,
                height: 46,
                buttonType: MainButtonType.outlined,
                title_color: JAppColors.primary,
                text_fontweight: FontWeight.w500,
                image_value: false,
                onTap: () {
                  AppRouter.router.push('/blogCreateScreen');
                },
                text_size: JSizes.fontSizeMd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}