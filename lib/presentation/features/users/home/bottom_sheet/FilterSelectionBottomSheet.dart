import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
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

class _FilterSelectionBottomSheetState extends State<FilterSelectionBottomSheet> {
  late Map<String, List<String>> selectedFilters;

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

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.backGroundDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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

          Expanded(
            child: ListView(
              children: [
                ...filterOptions.entries.map((category) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        category.key,
                        style: AppTextStyle.dmSans(
                          color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                          fontSize: 18.0,
                          weight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: category.value.map((option) {
                          final selected = isSelected(category.key, option);
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
                              toggleFilter(category.key, option);
                            },
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Apply Filters Button
          Container(
            margin: const EdgeInsets.only(bottom: 16, top: 8),
            child: ElevatedButton(
              onPressed: applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6), // Purple color
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Apply Filters',
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
}

// Example usage:
class FilterButton extends StatelessWidget {
  final Map<String, List<String>> currentFilters;
  final Function(Map<String, List<String>>) onFiltersChanged;

  const FilterButton({
    super.key,
    required this.currentFilters,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.filter_list),
      label: Text('Filters ${currentFilters.isEmpty ? '' : '(${_getFilterCount()})'}'),
      onPressed: () async {
        final result = await FilterSelectionBottomSheet.show(
          context,
          initialFilters: currentFilters,
        );

        if (result != null) {
          onFiltersChanged(result);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: currentFilters.isEmpty
            ? Colors.grey.shade200
            : const Color(0xFF8B5CF6).withOpacity(0.1),
        foregroundColor: currentFilters.isEmpty
            ? Colors.black87
            : const Color(0xFF8B5CF6),
      ),
    );
  }

  int _getFilterCount() {
    int count = 0;
    for (var filters in currentFilters.values) {
      count += filters.length;
    }
    return count;
  }
}