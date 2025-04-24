import 'package:flutter/material.dart';
import 'package:job_contracts/utils/common_widgets/text_field_widget.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';

import '../../../routes/app_routes.dart';

class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({super.key});

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  String _selectedCategory = 'Labor';

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.createAd,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: Padding(
          padding: const EdgeInsets.all(3.0),
          child: BackCircle(
            isDark: isDark,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ad Category
              _buildSectionTitle(JText.adCategory, isDark),
              const SizedBox(height: 8),
              _buildDropdownField(isDark),
              const SizedBox(height: 24),
              TextFieldWidget(
                subTitle: JText.adTitle,
                hintText: JText.writeTitleHere,
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              ),
              // Ad Title
              const SizedBox(height: 24),
              TextFieldWidget(
                subTitle: JText.price,
                hintText: "1600",
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              ),


              // Ad Description
              const SizedBox(height: 16),
              _buildSectionTitle(JText.adDescription, isDark),
              const SizedBox(height: 10),

              Container(
                height: 300 ,
                decoration: BoxDecoration(
                  color: isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  maxLines: null,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Date Section
              Row(
                children: [
                  // Start Date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(JText.startDate, isDark),
                        const SizedBox(height: 8),
                        _buildDateField(
                          controller: _startDateController,
                          isDark: isDark,
                          onTap: () => _selectDate(context, _startDateController),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // End Date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(JText.endDate, isDark),
                        const SizedBox(height: 8),
                        _buildDateField(
                          controller: _endDateController,
                          isDark: isDark,
                          onTap: () => _selectDate(context, _endDateController),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Map Location
              _buildSectionTitle(JText.mapLocation, isDark),
              const SizedBox(height: 8),
              _buildMapSection(isDark),
              const SizedBox(height: 24),

              // Next Step Button
              MainButton(
                btn_title: JText.nextStep,
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Color(0xff7030F1),
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,
                onTap: () {
                  AppRouter.router.push('/adUploadScreen');
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: AppTextStyle.dmSans(
        color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
        fontSize: 16.0,
        weight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDropdownField(bool isDark) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          isExpanded: true,

          padding: const EdgeInsets.symmetric(horizontal: 16),
          borderRadius: BorderRadius.circular(8),
          dropdownColor: isDark ? JAppColors.darkGray700 : Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: <String>['Labor', 'Services', 'Goods', 'Rentals']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.dmSans(
                  weight: FontWeight.w400,
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 16.0,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedCategory = newValue;
              });
            }
          },
        ),
      ),
    );
  }


  Widget _buildDateField({
    required TextEditingController controller,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                controller.text.isEmpty ? '' : controller.text,
                style: AppTextStyle.dmSans(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 16.0, weight: FontWeight.w400,
                ),
              ),
            ),
            Icon(
              Icons.calendar_today_outlined,
              color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection(bool isDark) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Replace this with actual map implementation

          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: JAppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    JText.traceMe,
                    style: AppTextStyle.dmSans(
                      color: Colors.white,
                      fontSize: 14.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}