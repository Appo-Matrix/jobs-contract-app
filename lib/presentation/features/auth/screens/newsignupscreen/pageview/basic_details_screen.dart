import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../../utils/common_widgets/international_phone_widget.dart';
import '../../../../../../utils/common_widgets/main_button.dart';
import '../../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/device/device_utility.dart';

class BasicDetailsScreen extends StatefulWidget {
  final String selectedRole;
  final Function(Map<String, dynamic>) onContinue;
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

  // Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Phone
  String _fullPhoneNumber = '';

  // Location
  double? _latitude;
  double? _longitude;
  bool _isLoadingLocation = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ====== LOCATION ======
  Future<void> _getCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showError('locationServicesDisabled'.tr());
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showError('locationPermissionDenied'.tr());
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showError('locationPermissionPermanentlyDenied'.tr());
        await Geolocator.openAppSettings();
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });

      debugPrint('📍 Location obtained: ($_latitude, $_longitude)');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('locationObtained'.tr()),
            backgroundColor: JAppColors.primary,
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Error getting location: $e');
      _showError('errorGettingLocation'.tr());
    } finally {
      if (mounted) setState(() => _isLoadingLocation = false);
    }
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

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _handleContinue() {
    if (!_formKey.currentState!.validate()) return;

    if (_fullPhoneNumber.isEmpty) {
      _showError('pleaseEnterPhone'.tr());
      return;
    }

    if (_latitude == null || _longitude == null) {
      _showError('pleaseGetLocation'.tr());
      return;
    }

    final data = {
      'fullName': _fullNameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
      'phone': _fullPhoneNumber,
      'location': {
        'type': 'Point',
        'coordinates': [
          _longitude.toString(),
          _latitude.toString(),
        ],
      },
    };

    debugPrint('✅ Basic Details ready: $data');
    widget.onContinue(data);
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
                    color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'fillBasicInfo'.tr(),
                  style: AppTextStyle.dmSans(
                    fontSize: 15.0,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray500,
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
                  titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                ),
                const SizedBox(height: 20),

                // ====== EMAIL ======
                TextFieldWidget(
                  subTitle: 'email',
                  hintText: 'emailEnter',
                  textEditingController: _emailController,
                  validator: _validateEmail,
                  isRequired: true,
                  titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
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
                  titleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                ),
                const SizedBox(height: 20),

                // ====== PHONE ======
                InternationalPhoneWidget(
                  title: 'phone',
                  hintText: 'enterPhoneNumber'.tr(),
                  isRequired: true,
                  initialCountryCode: 'PK',
                  onChanged: (phone) {
                    setState(() => _fullPhoneNumber = phone);
                    debugPrint('📞 Phone: $phone');
                  },
                ),
                const SizedBox(height: 24),

                // ====== LOCATION ======
                Text(
                  'location'.tr(),
                  style: AppTextStyle.dmSans(
                    fontSize: 14.0,
                    weight: FontWeight.w500,
                    color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _latitude != null
                        ? (isDark
                        ? JAppColors.primary.withOpacity(0.1)
                        : const Color(0xFFE8E4FF))
                        : (isDark
                        ? JAppColors.darkGray300.withOpacity(0.3)
                        : Colors.grey[100]),
                    border: Border.all(
                      color: _latitude != null
                          ? JAppColors.primary
                          : Colors.grey[300]!,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _latitude != null
                            ? Icons.location_on
                            : Icons.location_off_outlined,
                        color: _latitude != null
                            ? JAppColors.primary
                            : (isDark
                            ? JAppColors.darkGray100
                            : JAppColors.darkGray500),
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _latitude != null
                              ? '${'locationObtained'.tr()}\n'
                              '${_latitude!.toStringAsFixed(5)}, '
                              '${_longitude!.toStringAsFixed(5)}'
                              : 'tapToGetLocation'.tr(),
                          style: AppTextStyle.dmSans(
                            fontSize: 13.0,
                            color: _latitude != null
                                ? JAppColors.primary
                                : (isDark
                                ? JAppColors.darkGray100
                                : JAppColors.darkGray500),
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _isLoadingLocation
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: JAppColors.primary,
                        ),
                      )
                          : TextButton(
                        onPressed: _getCurrentLocation,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          backgroundColor: JAppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          _latitude != null
                              ? 'refresh'.tr()
                              : 'getLocation'.tr(),
                          style: AppTextStyle.dmSans(
                            fontSize: 12.0,
                            color: Colors.white,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    icon: const Icon(
                      Icons.arrow_back,
                      color: JAppColors.primary,
                      size: 20,
                    ),
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