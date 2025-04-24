import 'package:flutter/material.dart';

import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class SearchableBottomSheetContent extends StatefulWidget {
  final bool isDark;
  final String educationText;

  const SearchableBottomSheetContent({
    super.key,
    required this.isDark,
    required this.educationText,
  });

  @override
  _SearchableBottomSheetContentState createState() =>
      _SearchableBottomSheetContentState();
}

class _SearchableBottomSheetContentState extends State<SearchableBottomSheetContent> {
  late TextEditingController _searchController;
  late List<String> filteredEducationList;
  late List<String> educationList; // List to hold the original data

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    filteredEducationList = [widget.educationText];  // Initialize with the initial education text
    educationList = [widget.educationText];  // Use the same initial education text for simplicity
  }

  // Filter the education list based on search input
  void _filterEducationList(String query) {
    final filteredList = educationList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredEducationList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,  // Ensures the bottom sheet takes minimum space needed
        children: [
          Text(
            widget.educationText, // Title of the BottomSheet
            style: AppTextStyle.dmSans(
              color: widget.isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
              fontSize: 20.0,
              weight: FontWeight.w600,
            ),
          ),
          SizedBox(height: JSizes.spaceBtwInputFields), // Adds space after title

          // Search Field
          TextField(
            controller: _searchController,
            onChanged: _filterEducationList,
            decoration: InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.isDark ? JAppColors.lightGray100 : JAppColors.darkGray800.withValues(alpha: 0.5),
                ),
              ),
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            ),
          ),
          SizedBox(height: JSizes.spaceBtwInputFields), // Space after search field

          // Display filtered results
          Expanded(
            child: ListView.builder(
              itemCount: filteredEducationList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    filteredEducationList[index],
                    style: AppTextStyle.dmSans(
                      color: widget.isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                      fontSize: 16.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
