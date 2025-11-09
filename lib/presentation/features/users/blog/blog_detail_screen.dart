import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_avatar.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/device/device_utility.dart';

class BlogDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final List<String> tags;
  final String author;
  final String publishDate;
  final int readTime;

  const BlogDetailScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.tags,
    this.author = 'John Doe',
    this.publishDate = 'Oct 20, 2025',
    this.readTime = 5,
  });

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
        actions: [

          CircularAvatar(
            isDark: isDark,
            radius: 18,
            imageUrl: JImages.image,
          ),

          SizedBox(width: 16,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tags
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? JAppColors.darkGray700.withOpacity(0.5)
                              : JAppColors.lightGray300,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          tag,
                          style: AppTextStyle.dmSans(
                            fontSize: 12.0,
                            weight: FontWeight.w500,
                            color: isDark
                                ? JAppColors.darkGray100
                                : JAppColors.darkGray700,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Title
                  Text(
                    title,
                    style: AppTextStyle.dmSans(
                      fontSize: 24.0,
                      weight: FontWeight.w700,
                      color: isDark
                          ? JAppColors.darkGray100
                          : JAppColors.darkGray800,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Author and Meta Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(JImages.image),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              author,
                              style: AppTextStyle.dmSans(
                                fontSize: 14.0,
                                weight: FontWeight.w600,
                                color: isDark
                                    ? JAppColors.darkGray100
                                    : JAppColors.darkGray800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$publishDate • $readTime min read',
                              style: AppTextStyle.dmSans(
                                fontSize: 12.0,
                                weight: FontWeight.w400,
                                color: isDark
                                    ? JAppColors.darkGray400
                                    : JAppColors.darkGray600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Divider
                  Divider(
                    color: isDark
                        ? JAppColors.darkGray700
                        : JAppColors.lightGray300,
                    thickness: 1,
                  ),

                  const SizedBox(height: 24),

                  // Blog Content
                  _buildBlogContent(isDark),

                  const SizedBox(height: 32),

                  // Divider
                  Divider(
                    color: isDark
                        ? JAppColors.darkGray700
                        : JAppColors.lightGray300,
                    thickness: 1,
                  ),

                  const SizedBox(height: 16),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogContent(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Introduction
        Text(
          'Construction has always been about building the future. Today, that future is being transformed by digital tools, automation, and innovative technologies that are reshaping how we plan, design, and execute projects.',
          style: AppTextStyle.dmSans(
            fontSize: 16.0,
            weight: FontWeight.w400,
            color: isDark ? JAppColors.darkGray200 : JAppColors.darkGray700,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 24),

        // Section 1
        Text(
          'The Digital Revolution',
          style: AppTextStyle.dmSans(
            fontSize: 20.0,
            weight: FontWeight.w700,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'The construction industry is undergoing a massive transformation. From Building Information Modeling (BIM) to drones and IoT sensors, technology is enabling unprecedented levels of efficiency, accuracy, and collaboration.',
          style: AppTextStyle.dmSans(
            fontSize: 16.0,
            weight: FontWeight.w400,
            color: isDark ? JAppColors.darkGray200 : JAppColors.darkGray700,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Digital platforms are connecting stakeholders like never before, breaking down silos between architects, contractors, and clients. This connectivity leads to better communication, fewer errors, and faster project completion.',
          style: AppTextStyle.dmSans(
            fontSize: 16.0,
            weight: FontWeight.w400,
            color: isDark ? JAppColors.darkGray200 : JAppColors.darkGray700,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 24),

        // Section 2
        Text(
          'Key Technologies Driving Change',
          style: AppTextStyle.dmSans(
            fontSize: 20.0,
            weight: FontWeight.w700,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),

        const SizedBox(height: 12),

        _buildBulletPoint(
          isDark: isDark,
          text:
          'Building Information Modeling (BIM): Creating detailed 3D models that improve planning and reduce waste',
        ),
        _buildBulletPoint(
          isDark: isDark,
          text:
          'IoT Sensors: Real-time monitoring of construction sites for safety and efficiency',
        ),
        _buildBulletPoint(
          isDark: isDark,
          text:
          'Drones: Aerial surveys and progress tracking that save time and improve accuracy',
        ),
        _buildBulletPoint(
          isDark: isDark,
          text:
          'AI and Machine Learning: Predictive analytics for better project management',
        ),

        const SizedBox(height: 24),

        // Quote Box
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isDark
                ? JAppColors.darkGray700.withOpacity(0.3)
                : JAppColors.lightGray200,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: isDark
                  ? JAppColors.darkGray600
                  : JAppColors.lightGray400,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.format_quote,
                color: isDark ? JAppColors.darkGray400 : JAppColors.darkGray600,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Technology is not just changing how we build—it\'s changing what we can build and who can participate in the process.',
                  style: AppTextStyle.dmSans(
                    fontSize: 16.0,
                    weight: FontWeight.w500,
                    color: isDark
                        ? JAppColors.darkGray200
                        : JAppColors.darkGray700,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Conclusion
        Text(
          'Looking Ahead',
          style: AppTextStyle.dmSans(
            fontSize: 20.0,
            weight: FontWeight.w700,
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray800,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'As we move forward, the integration of these technologies will only deepen. The construction sites of tomorrow will be smarter, safer, and more sustainable. For professionals in the industry, embracing these changes isn\'t optional—it\'s essential for staying competitive and delivering the best results for clients.',
          style: AppTextStyle.dmSans(
            fontSize: 16.0,
            weight: FontWeight.w400,
            color: isDark ? JAppColors.darkGray200 : JAppColors.darkGray700,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint({required bool isDark, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8.0, right: 12.0),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isDark ? JAppColors.darkGray400 : JAppColors.darkGray600,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.dmSans(
                fontSize: 16.0,
                weight: FontWeight.w400,
                color: isDark ? JAppColors.darkGray200 : JAppColors.darkGray700,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

}