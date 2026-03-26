import 'package:flutter/material.dart';
import '../constants/app_text_style.dart';
import '../constants/colors.dart';
import '../helpers/AvatarHelper.dart';

class CircularAvatar extends StatelessWidget {
  final bool isDark;
  final double radius;
  final String? imageUrl;
  final bool isNetworkImage;
  final Color borderColor;
  final double borderWidth;
  final String? initials;
  final String? name;
  final bool asset;

  const CircularAvatar({
    super.key,
    required this.isDark,
    required this.radius,
    this.imageUrl,
    this.isNetworkImage = false,
    this.borderColor = Colors.grey,
    this.borderWidth = 2.0,
    this.initials,
    this.name,
    this.asset = false,
  });

  ImageProvider? _getImageProvider() {
    if (imageUrl == null || imageUrl!.isEmpty) return null;
    try {
      if (isNetworkImage) return NetworkImage(imageUrl!);
      return AssetImage(imageUrl!);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = _getImageProvider();

    // ✅ Delegate both initials and color entirely to AvatarHelper
    final letters = initials ?? AvatarHelper.getInitials(name);
    final avatarColor = AvatarHelper.getColor(name ?? initials);

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
          backgroundColor: imageProvider == null
              ? avatarColor
              : (isDark ? Colors.grey[800] : Colors.grey[200]),
          backgroundImage: imageProvider,
          child: imageProvider == null
              ? Text(
            letters,


            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
              fontSize: 18.0,
              weight: FontWeight.w600,
            ),

          )
              : null,
        ),
      ),
    );
  }
}