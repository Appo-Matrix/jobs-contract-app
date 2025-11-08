// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:job_contract_client/utils/constants/colors.dart';
// import 'package:job_contract_client/utils/device/device_utility.dart';
// import '../../../../../utils/common_widgets/main_button.dart';
// import '../../../../../utils/common_widgets/text_field_widget.dart';
// import '../../../../../utils/constants/app_text_style.dart';
//
// class BasicDetailsScreen extends StatefulWidget {
//   final String selectedRole;
//   final Function(Map<String, String>) onContinue;
//   final VoidCallback onBack;
//
//   const BasicDetailsScreen({
//     super.key,
//     required this.selectedRole,
//     required this.onContinue,
//     required this.onBack,
//   });
//
//   @override
//   State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
// }
//
// class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _obscurePassword = true;
//
//   // Controllers
//   final _fullNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _phoneController = TextEditingController();
//   String? _selectedLocation;
//
//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   // ====== VALIDATORS ======
//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) return 'emailRequired'.tr();
//     final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!regex.hasMatch(value)) return 'emailInvalid'.tr();
//     return null;
//   }
//
//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) return 'passwordRequired'.tr();
//     if (value.length < 8) return 'passwordMinLength'.tr();
//     if (!value.contains(RegExp(r'[A-Z]'))) return 'passwordUppercase'.tr();
//     if (!value.contains(RegExp(r'[0-9]'))) return 'passwordNumber'.tr();
//     return null;
//   }
//
//   String? _validateRequired(String? value, String fieldName) {
//     if (value == null || value.isEmpty) {
//       return '$fieldName ${'isRequired'.tr()}';
//     }
//     return null;
//   }
//
//   void _handleContinue() {
//     if (_formKey.currentState!.validate()) {
//       if (_selectedLocation == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('selectLocationFirst'.tr()),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return;
//       }
//
//       final data = {
//         'fullName': _fullNameController.text,
//         'email': _emailController.text,
//         'password': _passwordController.text,
//         'phone': _phoneController.text,
//         'location': _selectedLocation!,
//       };
//
//       widget.onContinue(data);
//     }
//   }
//
//   void _handleLocationSelection() {
//     setState(() {
//       _selectedLocation = 'Selected Location';
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('locationSelected'.tr()),
//         backgroundColor: JAppColors.primary,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = JDeviceUtils.isDarkMode(context);
//
//     return Scaffold(
//       backgroundColor: isDark ? JAppColors.darkBackground : Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ====== TITLE ======
//                 Text(
//                   'basicDetails',
//                   style: AppTextStyle.dmSans(
//                     fontSize: 26.0,
//                     weight: FontWeight.w700,
//                     color: isDark
//                         ? JAppColors.lightGray100
//                         : JAppColors.darkGray900,
//                   ),
//                 ).tr(),
//                 const SizedBox(height: 8),
//                 Text(
//                   'fillBasicInfo',
//                   style: AppTextStyle.dmSans(
//                     fontSize: 15.0,
//                     color: isDark
//                         ? JAppColors.darkGray100
//                         : JAppColors.darkGray500,
//                     weight: FontWeight.w400,
//                   ),
//                 ).tr(),
//                 const SizedBox(height: 30),
//
//                 // ====== SELECTED ROLE ======
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: isDark
//                         ? JAppColors.primary.withOpacity(0.1)
//                         : const Color(0xFFE8E4FF),
//                     border: Border.all(color: JAppColors.primary),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         widget.selectedRole == 'contractor'
//                             ? Icons.person_outline
//                             : Icons.business_outlined,
//                         color: JAppColors.primary,
//                         size: 20,
//                       ),
//                       const SizedBox(width: 12),
//                       Text(
//                         '${'selectedRole'.tr()}: ${widget.selectedRole[0].toUpperCase()}${widget.selectedRole.substring(1)}',
//                         style: AppTextStyle.dmSans(
//                           fontSize: 15.0,
//                           color: JAppColors.primary,
//                           weight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // ====== FULL NAME ======
//                 TextFieldWidget(
//                   subTitle: 'fullName',
//                   hintText: 'enterYourName'.tr(),
//                   textEditingController: _fullNameController,
//                   validator: (v) => _validateRequired(v, 'Full name'),
//                   isRequired: true,
//                   titleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                   subtitleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                 ),
//                 const SizedBox(height: 20),
//
//                 // ====== EMAIL ======
//                 TextFieldWidget(
//                   subTitle: 'email',
//                   hintText: 'emailEnter',
//                   textEditingController: _emailController,
//                   validator: _validateEmail,
//                   isRequired: true,
//                   titleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                   subtitleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                 ),
//                 const SizedBox(height: 20),
//
//                 // ====== PASSWORD ======
//                 TextFieldWidget(
//                   subTitle: 'password',
//                   hintText: '******',
//                   isPassword: true,
//                   isRequired: true,
//                   textEditingController: _passwordController,
//                   validator: _validatePassword,
//                   titleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                   subtitleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                 ),
//                 const SizedBox(height: 20),
//
//                 // ====== LOCATION SELECTOR ======
//                 Text(
//                   'location'.tr(),
//                   style: AppTextStyle.dmSans(
//                     fontSize: 14.0,
//                     weight: FontWeight.w500,
//                     color: isDark
//                         ? JAppColors.lightGray100
//                         : JAppColors.darkGray800,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 GestureDetector(
//                   onTap: _handleLocationSelection,
//                   child: Container(
//                     height: 150,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: _selectedLocation == null
//                             ? (isDark ? JAppColors.darkGray300 : Colors.grey[300]!)
//                             : JAppColors.primary,
//                         width: _selectedLocation == null ? 1 : 2,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                       color: isDark
//                           ? JAppColors.darkGray300.withOpacity(0.3)
//                           : Colors.grey[100],
//                       image: const DecorationImage(
//                         image: NetworkImage(
//                             'https://via.placeholder.com/400x150/E0E0E0/757575?text=Map+Placeholder'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     child: _selectedLocation != null
//                         ? Center(
//                       child: Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: const Icon(
//                           Icons.location_on,
//                           color: JAppColors.primary,
//                           size: 32,
//                         ),
//                       ),
//                     )
//                         : Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.add_location_alt_outlined,
//                             color: isDark
//                                 ? JAppColors.darkGray100
//                                 : JAppColors.darkGray500,
//                             size: 32,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'tapToSelectLocation'.tr(),
//                             style: AppTextStyle.dmSans(
//                               fontSize: 14.0,
//                               color: isDark
//                                   ? JAppColors.darkGray100
//                                   : JAppColors.darkGray500,
//                               weight: FontWeight.w400,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // ====== PHONE ======
//                 TextFieldWidget(
//                   subTitle: 'phone',
//                   hintText: 'enterPhoneNumber',
//                   textEditingController: _phoneController,
//                   keyboardType: TextInputType.phone,
//                   isRequired: false,
//                   titleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                   subtitleColor: isDark
//                       ? JAppColors.lightGray100
//                       : JAppColors.darkGray800,
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // ====== CONTINUE BUTTON ======
//                 MainButton(
//                   onTap: _handleContinue,
//                   btn_color: JAppColors.primary,
//                   btn_title: 'continue',
//                   btn_radius: 12,
//                   btn_boarder_color: JAppColors.primary,
//                   title_color: Colors.white,
//                   text_fontweight: FontWeight.w600,
//                   image_value: false,
//                   isDark: isDark,
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // ====== BACK BUTTON ======
//                 Center(
//                   child: TextButton.icon(
//                     onPressed: widget.onBack,
//                     icon: const Icon(Icons.arrow_back, color: JAppColors.primary, size: 20),
//                     label: Text(
//                       'back'.tr(),
//                       style: AppTextStyle.dmSans(
//                         fontSize: 15.0,
//                         color: JAppColors.primary,
//                         weight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../utils/common_widgets/main_button.dart';
import '../../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/device/device_utility.dart';


class BasicDetailsScreen extends StatefulWidget {
  final String selectedRole;
  final Function(Map<String, String>) onContinue;
  final VoidCallback onBack;

  const BasicDetailsScreen({
    super.key,
    required this.selectedRole,
    required this.onContinue,
    required this.onBack,
  });

  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  // Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedLocation;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ====== VALIDATORS ======
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'emailRequired'.tr();
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'emailInvalid'.tr();
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'passwordRequired'.tr();
    if (value.length < 8) return 'passwordMinLength'.tr();
    if (!value.contains(RegExp(r'[A-Z]'))) return 'passwordUppercase'.tr();
    if (!value.contains(RegExp(r'[0-9]'))) return 'passwordNumber'.tr();
    return null;
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName ${'isRequired'.tr()}';
    }
    return null;
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      if (_selectedLocation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('selectLocationFirst'.tr()),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final data = {
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'phone': _phoneController.text,
        'location': _selectedLocation!,
      };

      widget.onContinue(data);
    }
  }

  void _handleLocationSelection() {
    setState(() {
      _selectedLocation = 'Selected Location';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('locationSelected'.tr()),
        backgroundColor: JAppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkBackground : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ====== TITLE ======
                Text(
                  'basicDetails'.tr(),
                  style: AppTextStyle.dmSans(
                    fontSize: 26.0,
                    weight: FontWeight.w700,
                    color: isDark
                        ? JAppColors.lightGray100
                        : JAppColors.darkGray900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'fillBasicInfo'.tr(),
                  style: AppTextStyle.dmSans(
                    fontSize: 15.0,
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.darkGray500,
                    weight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 30),

                // ====== SELECTED ROLE ======
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? JAppColors.primary.withOpacity(0.1)
                        : const Color(0xFFE8E4FF),
                    border: Border.all(color: JAppColors.primary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        widget.selectedRole == 'contractor'
                            ? Icons.person_outline
                            : Icons.business_outlined,
                        color: JAppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${'selectedRole'.tr()}: ${widget.selectedRole[0].toUpperCase()}${widget.selectedRole.substring(1)}',
                        style: AppTextStyle.dmSans(
                          fontSize: 15.0,
                          color: JAppColors.primary,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ====== FULL NAME ======
                TextFieldWidget(
                  subTitle: 'fullName',
                  hintText: 'enterYourName',
                  textEditingController: _fullNameController,
                  validator: (v) => _validateRequired(v, 'Full name'),
                  isRequired: true,
                  titleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  subtitleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                ),
                const SizedBox(height: 20),

                // ====== EMAIL ======
                TextFieldWidget(
                  subTitle: 'email',
                  hintText: 'emailEnter',

                  textEditingController: _emailController,
                  validator: _validateEmail,
                  isRequired: true,
                  titleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  subtitleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                ),
                const SizedBox(height: 20),

                // ====== PASSWORD ======
                TextFieldWidget(
                  subTitle: 'password',
                  hintText: '******',
                  isPassword: true,

                  isRequired: true,
                  textEditingController: _passwordController,
                  validator: _validatePassword,
                  titleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  subtitleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                ),
                const SizedBox(height: 20),

                // ====== LOCATION SELECTOR ======
                Text(
                  'location'.tr(),
                  style: AppTextStyle.dmSans(
                    fontSize: 14.0,
                    weight: FontWeight.w500,
                    color: isDark
                        ? JAppColors.lightGray100
                        : JAppColors.darkGray800,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _handleLocationSelection,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedLocation == null
                            ? (isDark ? JAppColors.darkGray300 : Colors.grey[300]!)
                            : JAppColors.primary,
                        width: _selectedLocation == null ? 1 : 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: isDark
                          ? JAppColors.darkGray300.withOpacity(0.3)
                          : Colors.grey[100],
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://via.placeholder.com/400x150/E0E0E0/757575?text=Map+Placeholder'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: _selectedLocation != null
                        ? Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: JAppColors.primary,
                          size: 32,
                        ),
                      ),
                    )
                        : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_location_alt_outlined,
                            color: isDark
                                ? JAppColors.darkGray100
                                : JAppColors.darkGray500,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'tapToSelectLocation'.tr(),
                            style: AppTextStyle.dmSans(
                              fontSize: 14.0,
                              color: isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.darkGray500,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ====== PHONE ======
                TextFieldWidget(
                  subTitle: 'phone',
                  hintText: 'enterPhoneNumber',
                  textEditingController: _phoneController,
                  keyboardType: TextInputType.phone,
                  isRequired: false,
                  titleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                  subtitleColor: isDark
                      ? JAppColors.lightGray100
                      : JAppColors.darkGray800,
                ),

                const SizedBox(height: 30),

                // ====== CONTINUE BUTTON ======
                MainButton(
                  onTap: _handleContinue,
                  btn_color: JAppColors.primary,
                  btn_title: 'continue',
                  btn_radius: 12,
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  isDark: isDark,
                ),

                const SizedBox(height: 16),

                // ====== BACK BUTTON ======
                Center(
                  child: TextButton.icon(
                    onPressed: widget.onBack,
                    icon: const Icon(Icons.arrow_back, color: JAppColors.primary, size: 20),
                    label: Text(
                      'back'.tr(),
                      style: AppTextStyle.dmSans(
                        fontSize: 15.0,
                        color: JAppColors.primary,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}