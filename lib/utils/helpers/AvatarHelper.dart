import 'package:flutter/material.dart';

/// Helper class for generating avatar-related data.
class AvatarHelper {
  /// Predefined colors for avatars.
  static const List<Color> _colors = [
    Color(0xFF5C6BC0), // indigo
    Color(0xFF26A69A), // teal
    Color(0xFFEF5350), // red
    Color(0xFFAB47BC), // purple
    Color(0xFF42A5F5), // blue
    Color(0xFFFF7043), // deep orange
    Color(0xFF66BB6A), // green
    Color(0xFFEC407A), // pink
  ];

  /// Returns a color based on [fullName].
  static Color getColor(String? fullName) {
    if (fullName == null || fullName.isEmpty) return _colors[0];
    final index = fullName.codeUnits.fold(0, (a, b) => a + b) % _colors.length;
    return _colors[index];
  }

  /// Returns initials from [fullName].
  /// If name is empty, returns "?".
  static String getInitials(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) return '?';
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}