import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/blog_card.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/device/device_utility.dart';
import 'blog_detail_screen.dart';


class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

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
          'Latest from Our Blog',
          style: AppTextStyle.dmSans(
            fontSize: 18.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),
        actions: [
          // Profile avatar
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),



            // Blog Cards List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 5, // Show multiple blog posts
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: BlogCard(
                    isDark: isDark,
                    imageUrl: _getBlogImage(index),
                    title: _getBlogTitle(index),
                    description: _getBlogDescription(),
                    tags: _getBlogTags(index),
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

                      // Navigate to blog detail
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 80), // Bottom spacing
          ],
        ),
      ),
    );
  }

  String _getBlogImage(int index) {
    final images = [
      'https://images.unsplash.com/photo-1503387762-592deb58ef4e?w=800',
      'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?w=800',
      'https://images.unsplash.com/photo-1590856029826-c7a73142bbf1?w=800',
      'https://images.unsplash.com/photo-1581094794329-c8112a89af12?w=800',
      'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=800',
    ];
    return images[index % images.length];
  }

  List<String> _getBlogTags(int index) {
    final tags = [
      ['Tech', 'Tech in Construction', 'Construction'],
      ['Tech', 'Innovation', 'Construction'],
      ['Tech', 'Tech in Construction', 'Construction'],
      ['Innovation', 'Digital', 'Construction'],
      ['Tech', 'Construction', 'Future'],
    ];
    return tags[index % tags.length];
  }

  String _getBlogTitle(int index) {
    final titles = [
      'How Technology is Reshaping the Construction Industry',
      'A New Digital Marketplace: Connecting Clients and Contractors',
      'One Platform, Endless Possibilities: From Planning to Execution',
      'The Future of Construction: Smart Buildings and IoT Integration',
      'Sustainable Construction Practices for Modern Projects',
    ];
    return titles[index % titles.length];
  }

  String _getBlogDescription() {
    return 'Construction has always been about building the future. Today, that future is being transformed by digital tools and automation...';
  }
}