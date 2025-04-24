import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  final bool isDark;
  final double radius;
  final String imageUrl;
  final bool isNetworkImage;
  final Color borderColor;
  final double borderWidth;
  final String? initials;
  final bool asset;

  const CircularAvatar({
    super.key,
    required this.isDark,
    required this.radius,
    required this.imageUrl,
    this.isNetworkImage = false,
    this.borderColor = Colors.grey,
    this.borderWidth = 2.0,
    this.initials,
    this.asset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2 + borderWidth * 2,
      height: radius * 2 + borderWidth * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark ? borderColor.withOpacity(0.5) : borderColor,
          width: borderWidth,
        ),
      ),
      child: ClipOval(
        child: CircleAvatar(
          radius: radius,
          backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
          backgroundImage: _getImageProvider(),
          child: _getImageProvider() == null && initials != null
              ? Text(
            initials!,
            style: TextStyle(
              fontSize: radius * 0.7,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black54,
            ),
          )
              : null,
        ),
      ),
    );
  }

  ImageProvider? _getImageProvider() {
    try {
      if (isNetworkImage) {
        return NetworkImage(imageUrl);
      } else if (asset) {
        return AssetImage(imageUrl);
      } else {
        // Default to AssetImage
        return AssetImage(imageUrl);
      }
    } catch (e) {
      return null; // Return null to show initials or default background
    }
  }
}