import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../my_ads_screen.dart';
import '../widgets/ad_card.dart';
import '../model/ad.dart';

class DraftAdsScreen extends StatefulWidget {
  final bool isDark;
  const DraftAdsScreen({Key? key, required this.isDark}) : super(key: key);

  @override
  State<DraftAdsScreen> createState() => _DraftAdsScreenState();
}

class _DraftAdsScreenState extends State<DraftAdsScreen> {
  late List<Ad> _draftAds;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate fetch delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _draftAds = _getDraftAds();
          _isLoading = false;
        });
      }
    });
  }

  List<Ad> _getDraftAds() {
    // This would be replaced with actual API call to fetch draft ads
    return [
      Ad(
        id: '5',
        title: "Roofing Materials",
        price: 2200,
        category: JText.labor,
        imageUrl: JImages.image,
      ),
      Ad(
        id: '6',
        title: "Painting Services",
        price: 780,
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

    if (_draftAds.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_note_outlined,
              size: 64,
              color: widget.isDark ? JAppColors.darkGray400 : JAppColors.lightGray400,
            ),
            const SizedBox(height: 16),
            Text(
              "No draft ads",
              style: AppTextStyle.dmSans(
                color: widget.isDark ? JAppColors.darkGray200 : JAppColors.lightGray700,
                fontSize: 16.0,
                weight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Saved drafts will appear here",
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
      itemCount: _draftAds.length,
      itemBuilder: (context, index) {
        final ad = _draftAds[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AdCard(
            ad: ad,
            isDark: widget.isDark,
            onViewDetails: () {
              // Navigation logic for viewing draft details
            },
            onEditAd: () {
              // Navigation logic for editing draft
            },
          ),
        );
      },
    );
  }
}