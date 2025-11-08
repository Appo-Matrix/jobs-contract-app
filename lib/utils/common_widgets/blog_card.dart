import 'package:flutter/material.dart';
import '../constants/app_text_style.dart';
import '../constants/colors.dart';

class BlogCard extends StatelessWidget {
  final bool isDark;
  final String imageUrl;
  final String title;
  final String description;
  final List<String> tags;
  final VoidCallback onReadMore;

  const BlogCard({
    super.key,
    required this.isDark,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.tags,
    required this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : Colors.grey[300]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((tag) => _buildBlogTag(tag, JAppColors.primary)).toList(),
                ),
                const SizedBox(height: 12),

                // Title
                Text(
                  title,
                  style: AppTextStyle.dmSans(
                    fontSize: 16.0,
                    weight: FontWeight.w700,
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.darkGray800,
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.dmSans(
                    fontSize: 13.0,
                    weight: FontWeight.w400,
                    color: isDark
                        ? JAppColors.darkGray300
                        : JAppColors.darkGray600,
                  ),
                ),
                const SizedBox(height: 12),

                // Read More Button
                GestureDetector(
                  onTap: onReadMore,
                  child: Row(
                    children: [
                      Text(
                        'Read More',
                        style: AppTextStyle.dmSans(
                          fontSize: 13.0,
                          weight: FontWeight.w600,
                          color:JAppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color:JAppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: AppTextStyle.dmSans(
          fontSize: 10.0,
          weight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
