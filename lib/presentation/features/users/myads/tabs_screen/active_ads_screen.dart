import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../widgets/ad_card.dart';
import '../model/ad.dart';

class ActiveAdsScreen extends StatefulWidget {
  final bool isDark;
  const ActiveAdsScreen({super.key, required this.isDark});

  @override
  State<ActiveAdsScreen> createState() => _ActiveAdsScreenState();
}

class _ActiveAdsScreenState extends State<ActiveAdsScreen> {
  late List<Ad> _activeAds;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate fetch delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _activeAds = _getActiveAds();
          _isLoading = false;
        });
      }
    });
  }

  List<Ad> _getActiveAds() {
    // This would be replaced with actual API call to fetch active ads
    return [
      Ad(
        id: '1',
        title: "Construction Material",
        price: 1600,
        category: JText.labor,
        imageUrl: JImages.image,
      ),
      Ad(
        id: '2',
        title: "Plumbing Services",
        price: 850,
        category: JText.labor,
        imageUrl: JImages.image,
      ),
      Ad(
        id: '3',
        title: "Electrical Work",
        price: 1200,
        category: JText.labor,
        imageUrl: JImages.image,
      ),
      Ad(
        id: '4',
        title: "Gardening Tools",
        price: 450,
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

    if (_activeAds.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 64,
              color: widget.isDark ? JAppColors.darkGray400 : JAppColors.lightGray400,
            ),
            const SizedBox(height: 16),
            Text(
              "No active ads yet",
              style: AppTextStyle.dmSans(
                color: widget.isDark ? JAppColors.darkGray200 : JAppColors.lightGray700,
                fontSize: 16.0,
                weight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Your published ads will appear here",
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
      itemCount: _activeAds.length,
      itemBuilder: (context, index) {
        final ad = _activeAds[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AdCard(
            ad: ad,
            isDark: widget.isDark,
            onViewDetails: () {
              // Navigate to ad details
              // AppRouter.router.push('/adDetailsScreen', extra: ad);
            },
            onEditAd: () {
              // Navigate to edit ad screen
              // AppRouter.router.push('/editAdScreen', extra: ad);
            },
          ),
        );
      },
    );
  }
}