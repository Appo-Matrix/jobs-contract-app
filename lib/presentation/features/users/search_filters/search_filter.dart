import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  // Define filter variables
  String? selectedLocation;
  String? selectedJobType;
  String? selectedCategory;
  RangeValues salaryRange = const RangeValues(0, 100000);

  // List of filter options for dropdowns
  final List<String> locations = ['New York', 'San Francisco', 'Chicago', 'Remote', 'Hybrid'];
  final List<String> jobTypes = ['Full-time', 'Part-time', 'Contract', 'Temporary', 'Internship'];
  final List<String> categories = ['Construction', 'Plumbing', 'Electrical', 'Carpentry', 'Roofing', 'HVAC', 'Landscaping', 'Painting'];

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.searchJob,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : JAppColors.lightGray900,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    JImages.search,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: JText.searchJob,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: AppTextStyle.dmSans(
                          fontSize: JSizes.fontSizeMd,
                          weight: FontWeight.w400,
                          color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
                        ),
                      ),
                      style: AppTextStyle.dmSans(
                        fontSize: JSizes.fontSizeMd,
                        weight: FontWeight.w400,
                        color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showFilterDialog(context),
                    child: SvgPicture.asset(
                      JImages.filters,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Active filters section
          if (selectedLocation != null || selectedJobType != null || selectedCategory != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Filters:',
                    style: AppTextStyle.dmSans(
                      fontSize: JSizes.fontSizeMd,
                      weight: FontWeight.w600,
                      color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (selectedLocation != null)
                        _buildFilterChip(context, 'Location: $selectedLocation', () {
                          setState(() => selectedLocation = null);
                        }),
                      if (selectedJobType != null)
                        _buildFilterChip(context, 'Type: $selectedJobType', () {
                          setState(() => selectedJobType = null);
                        }),
                      if (selectedCategory != null)
                        _buildFilterChip(context, 'Category: $selectedCategory', () {
                          setState(() => selectedCategory = null);
                        }),
                    ],
                  ),
                ],
              ),
            ),

          // Job results will be displayed here
          Expanded(
            child: Center(
              child: Text(
                'Job results will appear here based on your search and filters',
                textAlign: TextAlign.center,
                style: AppTextStyle.dmSans(
                  fontSize: JSizes.fontSizeLg,
                  weight: FontWeight.w400,
                  color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build filter chip widget
  Widget _buildFilterChip(BuildContext context, String label, VoidCallback onRemove) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeSm,
              weight: FontWeight.w500,
              color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray900,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 16,
              color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray700,
            ),
          ),
        ],
      ),
    );
  }

  // Show filter dialog
  void _showFilterDialog(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Jobs',
                        style: AppTextStyle.dmSans(
                          fontSize: JSizes.fontSizeLgx,
                          weight: FontWeight.w600,
                          color: isDark ? Colors.white : JAppColors.lightGray900,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark ? JAppColors.darkGray700 : JAppColors.lightGray200,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: isDark ? Colors.white : JAppColors.lightGray900,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Location Filter
                          _buildFilterSection(
                            context,
                            'Location',
                            _buildDropdown(
                              context,
                              selectedLocation,
                              locations,
                                  (value) {
                                setModalState(() {
                                  selectedLocation = value;
                                });
                              },
                            ),
                          ),

                          // Job Type Filter
                          _buildFilterSection(
                            context,
                            'Job Type',
                            _buildDropdown(
                              context,
                              selectedJobType,
                              jobTypes,
                                  (value) {
                                setModalState(() {
                                  selectedJobType = value;
                                });
                              },
                            ),
                          ),

                          // Category Filter
                          _buildFilterSection(
                            context,
                            'Category',
                            _buildDropdown(
                              context,
                              selectedCategory,
                              categories,
                                  (value) {
                                setModalState(() {
                                  selectedCategory = value;
                                });
                              },
                            ),
                          ),

                          // Salary Range Filter
                          _buildFilterSection(
                            context,
                            'Salary Range',
                            Column(
                              children: [
                                RangeSlider(
                                  values: salaryRange,
                                  min: 0,
                                  max: 100000,
                                  divisions: 20,
                                  activeColor: JAppColors.primary,
                                  inactiveColor: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
                                  labels: RangeLabels(
                                    '\$${salaryRange.start.round()}',
                                    '\$${salaryRange.end.round()}',
                                  ),
                                  onChanged: (RangeValues values) {
                                    setModalState(() {
                                      salaryRange = values;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${salaryRange.start.round()}',
                                        style: AppTextStyle.dmSans(
                                          fontSize: JSizes.fontSizeSm,
                                          weight: FontWeight.w500,
                                          color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray700,
                                        ),
                                      ),
                                      Text(
                                        '\$${salaryRange.end.round()}',
                                        style: AppTextStyle.dmSans(
                                          fontSize: JSizes.fontSizeSm,
                                          weight: FontWeight.w500,
                                          color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Apply and Reset Buttons
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setModalState(() {
                                selectedLocation = null;
                                selectedJobType = null;
                                selectedCategory = null;
                                salaryRange = const RangeValues(0, 100000);
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray700,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Reset',
                              style: AppTextStyle.dmSans(
                                fontSize: JSizes.fontSizeMd,
                                weight: FontWeight.w600,
                                color: isDark ? JAppColors.lightGray300 : JAppColors.lightGray700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                // Apply filters to the main screen
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: JAppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Apply Filters',
                              style: AppTextStyle.dmSans(
                                fontSize: JSizes.fontSizeMd,
                                weight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Build filter section with title and content
  Widget _buildFilterSection(BuildContext context, String title, Widget content) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
            color: isDark ? Colors.white : JAppColors.lightGray900,
          ),
        ),
        const SizedBox(height: 12),
        content,
        const SizedBox(height: 24),
      ],
    );
  }

  // Build dropdown for selection filters
  Widget _buildDropdown(
      BuildContext context,
      String? selectedValue,
      List<String> items,
      Function(String?) onChanged,
      ) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.darkGray700 : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(
            'Select option',
            style: AppTextStyle.dmSans(
              fontSize: JSizes.fontSizeMd,
              weight: FontWeight.w400,
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray500,
            ),
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: isDark ? Colors.white : JAppColors.lightGray900,
          ),
          isExpanded: true,
          dropdownColor: isDark ? JAppColors.darkGray700 : Colors.white,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeMd,
            weight: FontWeight.w400,
            color: isDark ? Colors.white : JAppColors.lightGray900,
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}