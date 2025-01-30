import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JDeviceUtils {

  /// Function to hide keyboard
  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// Status bar color change
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color)
    );
  }

  /// Return true if orientation = landscape
  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = View
        .of(context)
        .viewInsets;
    return viewInsets.bottom == 0;
  }

  /// Return true if orientation = portrait
  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View
        .of(context)
        .viewInsets;
    return viewInsets.bottom != 0;
  }

  /// Sets full screens

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  /// get screen height

  static double getScreenHeight(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .height;
  }

  /// get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .width;
  }

  /// get pixel ratio of device
  static double getPixelRatio(BuildContext context) {
    return MediaQuery
        .of(context)
        .devicePixelRatio;
  }

  ///  get status bar height
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery
        .of(context)
        .padding
        .top;
  }

  /// get bottom navigation bar height
  static double getNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  /// get appbar height
  static double getAppBarHeight() {
    return kToolbarHeight;
  }


  /// get keyboard height
  static double getKeyboardHeight(BuildContext context) {
    final viewInsets = MediaQuery
        .of(context)
        .viewInsets;
    return viewInsets.bottom;
  }

  /// check if keyboard is visible
  static Future<bool> isKeyboardVisible(BuildContext context) async {
    final viewInsets = View
        .of(context)
        .viewInsets;
    return viewInsets.bottom > 0;
  }

  /// Check is physical device
  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  /// Vibrate
  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate);
  }

  /// Set Orientation
  static Future<void> setPreferredOrientations(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  /// hide status bar

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  /// Show status bar
  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  /// Check internet connection
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Check if ios
  static bool isIOS() {
    return Platform.isIOS;
  }

  /// Check if android
  static bool isAndroid() {
    return Platform.isAndroid;
  }

  /// Launch url
  static void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Check if dark mode is enabled
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

}