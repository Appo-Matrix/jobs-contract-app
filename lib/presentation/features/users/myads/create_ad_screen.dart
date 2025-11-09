// import 'package:flutter/material.dart';
// import 'package:job_contracts/utils/common_widgets/text_field_widget.dart';
// import '../../../../utils/common_widgets/appbar.dart';
// import '../../../../utils/common_widgets/back_circle.dart';
// import '../../../../utils/common_widgets/main_button.dart';
// import '../../../../utils/constants/app_text_style.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/text_strings.dart';
// import '../../../../utils/device/device_utility.dart';
//
// import '../../../routes/app_routes.dart';
//
// class CreateAdScreen extends StatefulWidget {
//   const CreateAdScreen({super.key});
//
//   @override
//   State<CreateAdScreen> createState() => _CreateAdScreenState();
// }
//
// class _CreateAdScreenState extends State<CreateAdScreen> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _startDateController = TextEditingController();
//   final TextEditingController _endDateController = TextEditingController();
//
//   String _selectedCategory = 'Labor';
//
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _priceController.dispose();
//     _descriptionController.dispose();
//     _startDateController.dispose();
//     _endDateController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       setState(() {
//         controller.text = "${picked.day}/${picked.month}/${picked.year}";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
//       appBar: JAppbar(
//         title: Text(
//           JText.createAd,
//           style: AppTextStyle.dmSans(
//             color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//             fontSize: 20.0,
//             weight: FontWeight.w600,
//           ),
//         ),
//         leadingIcon: Padding(
//           padding: const EdgeInsets.all(3.0),
//           child: BackCircle(
//             isDark: isDark,
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Ad Category
//               _buildSectionTitle(JText.adCategory, isDark),
//               const SizedBox(height: 8),
//               _buildDropdownField(isDark),
//               const SizedBox(height: 24),
//               TextFieldWidget(
//                 subTitle: JText.adTitle,
//                 hintText: JText.writeTitleHere,
//                 subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//                 titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//               ),
//               // Ad Title
//               const SizedBox(height: 24),
//               TextFieldWidget(
//                 subTitle: JText.price,
//                 hintText: "1600",
//                 subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//                 titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
//               ),
//
//
//               // Ad Description
//               const SizedBox(height: 16),
//               _buildSectionTitle(JText.adDescription, isDark),
//               const SizedBox(height: 10),
//
//               Container(
//                 height: 300 ,
//                 decoration: BoxDecoration(
//                   color: isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
//                   border: Border.all(color: Colors.grey[300]!),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: TextField(
//                   maxLines: null,
//
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     contentPadding: EdgeInsets.all(16),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // Date Section
//               Row(
//                 children: [
//                   // Start Date
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _buildSectionTitle(JText.startDate, isDark),
//                         const SizedBox(height: 8),
//                         _buildDateField(
//                           controller: _startDateController,
//                           isDark: isDark,
//                           onTap: () => _selectDate(context, _startDateController),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   // End Date
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _buildSectionTitle(JText.endDate, isDark),
//                         const SizedBox(height: 8),
//                         _buildDateField(
//                           controller: _endDateController,
//                           isDark: isDark,
//                           onTap: () => _selectDate(context, _endDateController),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//
//               // Map Location
//               _buildSectionTitle(JText.mapLocation, isDark),
//               const SizedBox(height: 8),
//               _buildMapSection(isDark),
//               const SizedBox(height: 24),
//
//               // Next Step Button
//               MainButton(
//                 btn_title: JText.nextStep,
//                 btn_radius: 10,
//                 btn_color: JAppColors.main,
//                 btn_border_color: Color(0xff7030F1),
//                 title_color: Colors.white,
//                 text_fontweight: FontWeight.w600,
//                 image_value: false,
//                 onTap: () {
//                   AppRouter.router.push('/adUploadScreen');
//                 },
//               ),
//
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title, bool isDark) {
//     return Text(
//       title,
//       style: AppTextStyle.dmSans(
//         color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//         fontSize: 16.0,
//         weight: FontWeight.w500,
//       ),
//     );
//   }
//
//   Widget _buildDropdownField(bool isDark) {
//     return Container(
//       height: 48,
//       decoration: BoxDecoration(
//         color: isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
//         ),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: _selectedCategory,
//           isExpanded: true,
//
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           borderRadius: BorderRadius.circular(8),
//           dropdownColor: isDark ? JAppColors.darkGray700 : Colors.white,
//           icon: const Icon(Icons.keyboard_arrow_down),
//           items: <String>['Labor', 'Services', 'Goods', 'Rentals']
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(
//                 value,
//                 style: AppTextStyle.dmSans(
//                   weight: FontWeight.w400,
//                   color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
//                   fontSize: 16.0,
//                 ),
//               ),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             if (newValue != null) {
//               setState(() {
//                 _selectedCategory = newValue;
//               });
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildDateField({
//     required TextEditingController controller,
//     required bool isDark,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 controller.text.isEmpty ? '' : controller.text,
//                 style: AppTextStyle.dmSans(
//                   color: isDark ? Colors.white : Colors.black,
//                   fontSize: 16.0, weight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             Icon(
//               Icons.calendar_today_outlined,
//               color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
//               size: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMapSection(bool isDark) {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: isDark ? JAppColors.darkGray600 : JAppColors.lightGray300,
//         ),
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: Stack(
//         children: [
//           // Replace this with actual map implementation
//
//           Positioned(
//             bottom: 16,
//             right: 16,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: JAppColors.primary,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.location_on,
//                     color: Colors.white,
//                     size: 18,
//                   ),
//                   const SizedBox(width: 4),
//                   Text(
//                     JText.traceMe,
//                     style: AppTextStyle.dmSans(
//                       color: Colors.white,
//                       fontSize: 14.0,
//                       weight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }


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
  // Page controller for multi-step form
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Step 1 Controllers
  final TextEditingController _projectTitleController = TextEditingController();
  final TextEditingController _projectDescriptionController = TextEditingController();
  final TextEditingController _minBudgetController = TextEditingController();
  final TextEditingController _maxBudgetController = TextEditingController();

  String _selectedCategory = 'Commercial';
  String _selectedUrgency = 'Normal';
  String _selectedWorkMode = 'On-site';
  String _selectedLocation = '';
  List<String> _uploadedFiles = [];

  // Step 2 Controllers
  String _selectedExperienceLevel = 'Mid-level (3-5 years)';
  String _selectedSchedule = 'Weekdays';
  Map<String, bool> _certifications = {
    'Licensed Contractor': false,
    'Safety Certified': false,
    'Project Management': false,
    'Certified Professional': false,
    'Quality Assurance': false,
    'Industry Specific License': false,
  };

  @override
  void dispose() {
    _pageController.dispose();
    _projectTitleController.dispose();
    _projectDescriptionController.dispose();
    _minBudgetController.dispose();
    _maxBudgetController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Final submission
      _publishAd();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _publishAd() {
    // Handle final submission
    print('Publishing ad...');
    // Navigate to success screen or home
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: _previousStep,
          ),
        ),
        title: Text(
          'Create New Ad',
          style: AppTextStyle.dmSans(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18.0,
            weight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          _buildProgressIndicator(isDark),

          // Page View
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                _buildStep1(isDark),
                _buildStep2(isDark),
                _buildStep3(isDark),
              ],
            ),
          ),

          // Next Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MainButton(
              btn_title: _currentStep == 2 ? 'Publish' : 'Next',
              btn_radius: 10,
              btn_color: JAppColors.primary,
              btn_border_color: JAppColors.primary,
              title_color: Colors.white,
              text_fontweight: FontWeight.w600,
              image_value: false,
              onTap: _nextStep,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _currentStep == 0
                ? 'Basic Information'
                : _currentStep == 1
                ? 'create_ad_contractor_prefs'
                : 'Preview & Publish',
            style: AppTextStyle.dmSans(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 16.0,
              weight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(3, (index) {
              bool isCompleted = index < _currentStep;
              bool isCurrent = index == _currentStep;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCompleted || isCurrent
                                  ? JAppColors.primary
                                  : Colors.grey[300],
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: AppTextStyle.dmSans(
                                  color: isCompleted || isCurrent
                                      ? Colors.white
                                      : Colors.grey[600]!,
                                  fontSize: 14.0,
                                  weight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          if (index < 2)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 2,
                              color: isCompleted
                                  ? JAppColors.primary
                                  : Colors.grey[300],
                            ),
                        ],
                      ),
                    ),
                    if (index < 2)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: isCompleted
                              ? JAppColors.primary
                              : Colors.grey[300],
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Step 1: Basic Information
  Widget _buildStep1(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Title
          _buildLabel('Project Title', true, isDark),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _projectTitleController,
            hintText: 'Project Title',
            isDark: isDark,
          ),
          const SizedBox(height: 20),

          // Project Description
          _buildLabel('Project Description', true, isDark),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _projectDescriptionController,
            hintText: 'Project Description',
            isDark: isDark,
            maxLines: 5,
          ),
          const SizedBox(height: 20),

          // Category
          _buildLabel('Category', true, isDark),
          const SizedBox(height: 8),
          _buildDropdown(
            value: _selectedCategory,
            items: ['Commercial', 'Residential', 'Industrial', 'Government'],
            hintText: 'Type a Blog Tags',
            isDark: isDark,
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
          const SizedBox(height: 20),

          // Min Budget
          _buildLabel('Min Budget', true, isDark),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _minBudgetController,
            hintText: 'Type a Blog Tags',
            isDark: isDark,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),

          // Category (duplicate in design)
          _buildLabel('Category', true, isDark),
          const SizedBox(height: 8),
          _buildTextField(
            controller: TextEditingController(),
            hintText: 'Type a Blog Tags',
            isDark: isDark,
          ),
          const SizedBox(height: 20),

          // Urgency
          _buildLabel('Urgency', false, isDark),
          const SizedBox(height: 8),
          _buildDropdown(
            value: _selectedUrgency,
            items: ['Normal', 'Urgent', 'Very Urgent'],
            hintText: 'Normal',
            isDark: isDark,
            onChanged: (value) {
              setState(() {
                _selectedUrgency = value!;
              });
            },
          ),
          const SizedBox(height: 20),

          // Work Mode
          _buildLabel('Work Mode', false, isDark),
          const SizedBox(height: 8),
          _buildDropdown(
            value: _selectedWorkMode,
            items: ['On-site', 'Remote', 'Hybrid'],
            hintText: 'On-site',
            isDark: isDark,
            onChanged: (value) {
              setState(() {
                _selectedWorkMode = value!;
              });
            },
          ),
          const SizedBox(height: 20),

          // Project Location
          _buildLabel('Project Location', true, isDark),
          const SizedBox(height: 8),
          _buildMapSection(isDark),
          const SizedBox(height: 20),

          // Attachments
          _buildLabel('Attachments', false, isDark),
          const SizedBox(height: 8),
          _buildAttachmentSection(isDark),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Step 2: Contractor Preferences
  Widget _buildStep2(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Minimum Experience Level
          _buildLabel('Minimum Experience Level', false, isDark),
          const SizedBox(height: 8),
          _buildDropdown(
            value: _selectedExperienceLevel,
            items: [
              'Entry-level (0-2 years)',
              'Mid-level (3-5 years)',
              'Senior (5-10 years)',
              'Expert (10+ years)',
            ],
            hintText: 'Minimum Experience Level',
            isDark: isDark,
            onChanged: (value) {
              setState(() {
                _selectedExperienceLevel = value!;
              });
            },
          ),
          const SizedBox(height: 24),

          // Desired Certifications
          _buildLabel('Desired Certifications (Optional)', false, isDark),
          const SizedBox(height: 12),
          ..._certifications.keys.map((cert) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _certifications[cert],
                      onChanged: (value) {
                        setState(() {
                          _certifications[cert] = value!;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    cert,
                    style: AppTextStyle.dmSans(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 15.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 24),

          // Schedule Preference
          _buildLabel('Schedule Preference', false, isDark),
          const SizedBox(height: 8),
          _buildDropdown(
            value: _selectedSchedule,
            items: ['Weekdays', 'Weekends', 'Flexible', 'Night Shift'],
            hintText: 'Schedule Preference',
            isDark: isDark,
            onChanged: (value) {
              setState(() {
                _selectedSchedule = value!;
              });
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Step 3: Preview & Publish
  Widget _buildStep3(bool isDark) {
    List<String> selectedCerts = _certifications.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Title
          Text(
            _projectTitleController.text.isNotEmpty
                ? _projectTitleController.text
                : 'Plumber And Electrician Needed',
            style: AppTextStyle.dmSans(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 24.0,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),

          // Category
          _buildPreviewItem('Category:', _selectedCategory, isDark),
          const SizedBox(height: 16),

          // Budget
          _buildPreviewItem(
            'Min Budget - Max Budget:',
            '\$${_minBudgetController.text} - \$${_maxBudgetController.text}',
            isDark,
          ),
          const SizedBox(height: 16),

          // Urgency
          _buildPreviewItem('Urgency:', _selectedUrgency.toLowerCase(), isDark),
          const SizedBox(height: 16),

          // Work Mode
          _buildPreviewItem('Work Mode:', _selectedWorkMode.toLowerCase(), isDark),
          const SizedBox(height: 16),

          // Project Description
          _buildPreviewLabel('Project Description:', isDark),
          const SizedBox(height: 8),
          Text(
            _projectDescriptionController.text.isNotEmpty
                ? _projectDescriptionController.text
                : 'Before embarking on your journey, take the time to research your destination.',
            style: AppTextStyle.dmSans(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 15.0,
              weight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),

          // Project Location
          _buildPreviewItem(
            'Project Location:',
            _selectedLocation.isNotEmpty ? _selectedLocation : 'Greater London',
            isDark,
          ),

          const Divider(height: 32),

          // Contractor Preferences Section
          Text(
            'Contractor Preferences',
            style: AppTextStyle.dmSans(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 20.0,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),

          // Min Experience
          _buildPreviewItem('Min Experience:', _selectedExperienceLevel, isDark),
          const SizedBox(height: 16),

          // Schedule
          _buildPreviewItem('Schedule:', _selectedSchedule.toLowerCase(), isDark),
          const SizedBox(height: 16),

          // Desired Certifications
          if (selectedCerts.isNotEmpty) ...[
            _buildPreviewLabel('Desired Certifications:', isDark),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedCerts.map((cert) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: JAppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    cert,
                    style: AppTextStyle.dmSans(
                      color: JAppColors.primary,
                      fontSize: 13.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLabel(String label, bool isRequired, bool isDark) {
    return RichText(
      text: TextSpan(
        text: label,
        style: AppTextStyle.dmSans(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 15.0,
          weight: FontWeight.w500,
        ),
        children: [
          if (isRequired)
            TextSpan(
              text: ' *',
              style: AppTextStyle.dmSans(
                color: Colors.red,
                fontSize: 15.0,
                weight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isDark,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? JAppColors.backGroundDarkCard : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : Colors.grey[300]!,
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: AppTextStyle.dmSans(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 15.0,
          weight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyle.dmSans(
            color: Colors.grey[400]!,
            fontSize: 15.0,
            weight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required String hintText,
    required bool isDark,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: isDark ? JAppColors.backGroundDarkCard : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : Colors.grey[300]!,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          borderRadius: BorderRadius.circular(8),
          dropdownColor: isDark ? JAppColors.darkGray700 : Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: AppTextStyle.dmSans(
                  weight: FontWeight.w400,
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 15.0,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildMapSection(bool isDark) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : Colors.grey[300]!,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // World map placeholder
          Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Equirectangular_projection_SW.jpg/1200px-Equirectangular_projection_SW.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentSection(bool isDark) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? JAppColors.darkGray600 : Colors.grey[300]!,
          style: BorderStyle.solid,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            'Upload files',
            style: AppTextStyle.dmSans(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 16.0,
              weight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Images, videos, PDFs (max 30MB each)',
            style: AppTextStyle.dmSans(
              color: Colors.grey[500]!,
              fontSize: 13.0,
              weight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewItem(String label, String value, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.dmSans(
            color: Colors.grey[600]!,
            fontSize: 14.0,
            weight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyle.dmSans(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 16.0,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewLabel(String label, bool isDark) {
    return Text(
      label,
      style: AppTextStyle.dmSans(
        color: Colors.grey[600]!,
        fontSize: 14.0,
        weight: FontWeight.w400,
      ),
    );
  }
}