import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/device/device_utility.dart';

class FilterSelectionBottomSheet extends StatefulWidget {
  final Function(Map<String, List<String>>) onApplyFilters;
  final Map<String, List<String>> initialFilters;

  const FilterSelectionBottomSheet({
    super.key,
    required this.onApplyFilters,
    this.initialFilters = const {},
  });

  static Future<Map<String, List<String>>?> show(
      BuildContext context, {
        Map<String, List<String>> initialFilters = const {},
      }) {
    return showModalBottomSheet<Map<String, List<String>>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.6,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return FilterSelectionBottomSheet(
            initialFilters: initialFilters,
            onApplyFilters: (filters) {
              Navigator.pop(context, filters);
            },
          );
        },
      ),
    );
  }

  @override
  State<FilterSelectionBottomSheet> createState() => _FilterSelectionBottomSheetState();
}

class _FilterSelectionBottomSheetState extends State<FilterSelectionBottomSheet> with SingleTickerProviderStateMixin {
  late Map<String, List<String>> selectedFilters;
  late TabController _tabController;
  int _activeTabIndex = 0;

  // Define filter categories and their options
  final Map<String, List<String>> filterOptions = {
    'Contract Category': [
      'Plumbing & Water Systems',
      'Plumbers',
      'Architects',
      'Engineers',
      'Design & Planning',
      'Electrical Systems & Wiring',
      'Woodwork & Structural Framing',
    ],
    'Contract Type': [
      'Residential Architect',
      'Plumbers',
      'Residential Plumber',
      'Ceiling Installer',
      'Commercial Electrician',
      'Structural Engineer',
      'Electrical Systems & Wiring',
    ],
    'Location': [
      'Liverpool',
      'Birmingham',
      'Leeds',
      'Sheffield',
      'Manchester',
      'Bristol',
      'Newcastle',
      'London',
    ],
    'Region': [
      'Wales',
      'England',
      'Scotland',
      'Northern Island',
      'Architects',
      'Engineers',
    ],
  };

  @override
  void initState() {
    super.initState();
    selectedFilters = Map<String, List<String>>.from(widget.initialFilters);
    _tabController = TabController(
      length: filterOptions.keys.length,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _activeTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void toggleFilter(String category, String option) {
    setState(() {
      if (selectedFilters.containsKey(category)) {
        if (selectedFilters[category]!.contains(option)) {
          selectedFilters[category]!.remove(option);
          if (selectedFilters[category]!.isEmpty) {
            selectedFilters.remove(category);
          }
        } else {
          selectedFilters[category]!.add(option);
        }
      } else {
        selectedFilters[category] = [option];
      }
    });
  }

  bool isSelected(String category, String option) {
    return selectedFilters.containsKey(category) &&
        selectedFilters[category]!.contains(option);
  }

  void applyFilters() {
    widget.onApplyFilters(selectedFilters);
  }

  void resetFilters() {
    setState(() {
      selectedFilters.clear();
    });
  }

  int getFilterCount(String category) {
    if (!selectedFilters.containsKey(category)) return 0;
    return selectedFilters[category]!.length;
  }

  int getTotalFilterCount() {
    int count = 0;
    for (var filters in selectedFilters.values) {
      count += filters.length;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final categories = filterOptions.keys.toList();

    return Container(
      decoration: BoxDecoration(
        color: isDark ? JAppColors.backGroundDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle bar and header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? JAppColors.backGroundDark : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                // Handle bar
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Header with Reset button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Filters',
                        style: AppTextStyle.dmSans(
                          color: isDark ? Colors.white : JAppColors.lightGray900,
                          fontSize: 18.0,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (getTotalFilterCount() > 0)
                      TextButton(
                        onPressed: resetFilters,
                        child: Text(
                          'Reset',
                          style: AppTextStyle.dmSans(
                            color: const Color(0xFF8B5CF6),
                            fontSize: 14.0,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Tab bar
          Container(
            decoration: BoxDecoration(
              color: isDark ? JAppColors.backGroundDark : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: const Color(0xFF8B5CF6),
              unselectedLabelColor: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
              labelStyle: AppTextStyle.dmSans(
                fontSize: 15.0,
                weight: FontWeight.w500, color:JAppColors.grayBlue600,
              ),
              indicatorColor: const Color(0xFF8B5CF6),
              indicatorWeight: 3,
              tabs: categories.map((category) {
                final count = getFilterCount(category);
                return Tab(
                  child: Row(
                    children: [
                      Text(category),
                      if (count > 0) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            count.toString(),
                            style: AppTextStyle.dmSans(
                              color: Colors.white,
                              fontSize: 12.0,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: categories.map((category) {
                return _buildFilterCategoryView(category, filterOptions[category]!);
              }).toList(),
            ),
          ),

          // Apply Filters Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? JAppColors.backGroundDark : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                getTotalFilterCount() > 0
                    ? 'Apply Filters (${getTotalFilterCount()})'
                    : 'Apply Filters',
                style: AppTextStyle.dmSans(
                  color: Colors.white,
                  fontSize: 16.0,
                  weight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterCategoryView(String category, List<String> options) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search box for filter options (optional)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? JAppColors.darkGray700 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 20,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search in ${category.toLowerCase()}',
                      border: InputBorder.none,
                      hintStyle: AppTextStyle.dmSans(
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        fontSize: 14.0, weight: FontWeight.w400,
                      ),
                    ),
                    style: AppTextStyle.dmSans(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 14.0, weight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Filter options
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                runSpacing: 12,
                children: options.map((option) {
                  final selected = isSelected(category, option);
                  return FilterChip(
                    label: Text(
                      option,
                      style: AppTextStyle.dmSans(
                        color: selected
                            ? Colors.white
                            : isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                        fontSize: 14.0,
                        weight: FontWeight.w400,
                      ),
                    ),
                    selected: selected,
                    backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    selectedColor: const Color(0xFF8B5CF6), // Purple color
                    checkmarkColor: Colors.white,
                    onSelected: (isSelected) {
                      toggleFilter(category, option);
                    },
                    showCheckmark: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}