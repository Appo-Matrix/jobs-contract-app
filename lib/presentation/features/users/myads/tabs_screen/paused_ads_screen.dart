import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../widgets/ad_card.dart';
import '../model/ad.dart';

class PausedAdsScreen extends StatefulWidget {
  final bool isDark;
  const PausedAdsScreen({super.key, required this.isDark});

  @override
  State<PausedAdsScreen> createState() => _PausedAdsScreenState();
}

class _PausedAdsScreenState extends State<PausedAdsScreen> {
  late List<Ad> _pausedAds;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate fetch delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _pausedAds = _getPausedAds();
          _isLoading = false;
        });
      }
    });
  }

  List<Ad> _getPausedAds() {
    // This would be replaced with actual API call to fetch paused ads
    return [
      Ad(
        id: '7',
        title: "Flooring Installation",
        price: 3500,
        category: JText.labor,
        imageUrl: JImages.image,
      ),
      Ad(
        id: '8',
        title: "Carpentry Tools",
        price: 900,
        category: JText.labor,
        imageUrl: JImages.image,
      ),
      Ad(
        id: '9',
        title: "Masonry Service",
        price: 1750,
        category: JText.labor,
        imageUrl: JImages.image,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: JAppColors.primary,
        ),
      );
    }

    if (_pausedAds.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pause_circle_outline,
              size: 64,
              color: widget.isDark ? JAppColors.darkGray400 : JAppColors.lightGray400,
            ),
            const SizedBox(height: 16),
            Text(
              "No paused ads",
              style: AppTextStyle.dmSans(
                color: widget.isDark ? JAppColors.darkGray200 : JAppColors.lightGray700,
                fontSize: 16.0,
                weight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Ads you've temporarily paused will appear here",
              style: AppTextStyle.dmSans(
                color: widget.isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
                fontSize: 14.0,
                weight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _pausedAds.length,
      itemBuilder: (context, index) {
        final ad = _pausedAds[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AdCard(
            ad: ad,
            isDark: widget.isDark,
            onViewDetails: () {
              // Navigation logic for viewing paused ad details
            },
            onEditAd: () {
              // Navigation logic for editing paused ad
            },
          ),
        );
      },
    );
  }
}