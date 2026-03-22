import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
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
import '../../../../data/models/blog/BlogModel.dart';
import '../providers/BlogProvider.dart';
import 'blog_detail_screen.dart';


class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ Uses correct provider and method name
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BlogProvider>().fetchBlogs();
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
          ),
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

      body: Consumer<BlogProvider>(
        builder: (context, blogProvider, _) {

          // ── Loading ────────────────────────────────────────────────────────
          if (blogProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ── Error ──────────────────────────────────────────────────────────
          if (blogProvider.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: JAppColors.error500),
                    const SizedBox(height: 16),
                    Text(
                      blogProvider.errorMessage!,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.dmSans(
                        fontSize: 14.0,
                        weight: FontWeight.w400,
                        color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => blogProvider.fetchBlogs(), // ✅ fetchBlogs
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // ── Empty ──────────────────────────────────────────────────────────
          if (blogProvider.blogs.isEmpty) {
            return Center(
              child: Text(
                'No blogs found',
                style: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  weight: FontWeight.w400,
                  color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
                ),
              ),
            );
          }

          // ── Data ───────────────────────────────────────────────────────────
          final blogs = blogProvider.blogs;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: RefreshIndicator(
              onRefresh: () => blogProvider.fetchBlogs(), // ✅ fetchBlogs
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
                        final BlogModel blog = blogs[index] as BlogModel;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: BlogCard(
                            isDark: isDark,
                            // ✅ Use image field (not imageUrl) matching BlogModel
                            imageUrl: blog.image!.isNotEmpty
                                ? blog.image!
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
                                    imageUrl: blog.image!.isNotEmpty
                                        ? blog.image!
                                        : 'https://via.placeholder.com/400x200',
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
                onTap: () => context.push('/myBlogScreen'), // ✅ context.push
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
                onTap: () => context.push('/blogCreateScreen'), // ✅ context.push
                text_size: JSizes.fontSizeMd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}