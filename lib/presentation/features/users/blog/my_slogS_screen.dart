import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../routes/app_routes.dart';

class MyBlogScreen extends StatefulWidget {
  const MyBlogScreen({super.key});

  @override
  State<MyBlogScreen> createState() => _MyBlogScreenState();
}

class _MyBlogScreenState extends State<MyBlogScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
          )
        ],
      ),
      body: Column(
        children: [
          // Header section with title and button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Blog Posts',
                  style: AppTextStyle.dmSans(
                    fontSize: 20.0,
                    weight: FontWeight.w700,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
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
                  onTap: () {
                    AppRouter.router.push('/blogCreateScreen');
                  },
                  text_size: 14,
                ),
              ],
            ),
          ),

          // Tabs
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
                unselectedLabelColor: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
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
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                ),
                tabs: const [
                  Tab(text: 'All (2)'),
                  Tab(text: 'Published (0)'),
                  Tab(text: 'Drafts (0)'),
                ],
              ),
            ),
          ),

          // Blog posts list
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // All tab
                _buildBlogList(isDark, 2),
                // Published tab
                _buildEmptyState(isDark, 'No Published Posts'),
                // Drafts tab
                _buildEmptyState(isDark, 'No Draft Posts'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogList(bool isDark, int itemCount) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? JAppColors.darkGray800 : JAppColors.lightGray100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray300,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Plumber And Electrician Needed',
                style: AppTextStyle.dmSans(
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
                ),
              ),
              const SizedBox(height: 12),

              // Created and Published info
              Row(
                children: [
                  Text(
                    'Created By ',
                    style: AppTextStyle.dmSans(
                      fontSize: 12.0,
                      weight: FontWeight.w400,
                      color: isDark ? JAppColors.darkGray400 : JAppColors.darkGray600,
                    ),
                  ),
                  Text(
                    'Aug2025',
                    style: AppTextStyle.dmSans(
                      fontSize: 12.0,
                      weight: FontWeight.w500,
                      color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    'Published ',
                    style: AppTextStyle.dmSans(
                      fontSize: 12.0,
                      weight: FontWeight.w400,
                      color: isDark ? JAppColors.darkGray400 : JAppColors.darkGray600,
                    ),
                  ),
                  Text(
                    'Sep 2025',
                    style: AppTextStyle.dmSans(
                      fontSize: 12.0,
                      weight: FontWeight.w500,
                      color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Tags
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTag('Plumber', isDark),
                  _buildTag('Electrical', isDark),
                ],
              ),
              const SizedBox(height: 16),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: MainButton(
                      btn_title: "Edit",
                      btn_radius: 8,
                      height: 44,
                      buttonType: MainButtonType.outlined,
                      title_color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray900,
                      text_fontweight: FontWeight.w500,
                      image_value: false,
                      onTap: () {
                        // TODO: Navigate to edit screen
                      },
                      text_size: 15,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MainButton(
                      btn_title: "Delete",
                      btn_radius: 8,
                      height: 44,
                      buttonType: MainButtonType.primary,
                      btn_color: JAppColors.error500,
                      title_color: Colors.white,
                      text_fontweight: FontWeight.w500,
                      image_value: false,
                      onTap: () {
                        _showDeleteDialog(context, isDark);
                      },
                      text_size: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTag(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: JAppColors.primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTextStyle.dmSans(
          fontSize: 12.0,
          weight: FontWeight.w500,
          color: JAppColors.primary,
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.article_outlined,
            size: 64,
            color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray500,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyle.dmSans(
              fontSize: 16.0,
              weight: FontWeight.w500,
              color: isDark ? JAppColors.darkGray400 : JAppColors.darkGray600,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, bool isDark) {
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
                  color: isDark ? JAppColors.darkGray300 : JAppColors.darkGray700,
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