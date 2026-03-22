import 'package:flutter/material.dart';
import '../../data/models/chat/ChatModel2.dart';
import '../constants/colors.dart';

class UserAvatar extends StatelessWidget {
  final OtherUser user;
  final double radius;

  const UserAvatar({
    super.key,
    required this.user,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ If profile image exists
    if (user.profile.isNotEmpty && user.profile.startsWith('http')) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(user.profile),
      );
    }

    // ✅ Generate initials
    final parts = user.fullName.trim().split(' ');
    final initials = parts.length >= 2
        ? '${parts[0][0]}${parts[1][0]}'
        : user.fullName.isNotEmpty
        ? user.fullName[0]
        : '?';

    return CircleAvatar(
      radius: radius,
      backgroundColor: JAppColors.primary,
      child: Text(
        initials.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: radius * 0.65,
        ),
      ),
    );
  }
}