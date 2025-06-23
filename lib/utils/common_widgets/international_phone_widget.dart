import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

class InternationalPhoneWidget extends StatefulWidget {
  final String? title;
  final String? hintText;
  final Color? titleColor;
  final Color? subtitleColor;
  final String? initialCountryCode;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final bool isRequired;
  final bool enabled;
  final TextEditingController? controller;

  const InternationalPhoneWidget({
    Key? key,
    this.title,
    this.hintText,
    this.titleColor,
    this.subtitleColor,
    this.initialCountryCode,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.isRequired = false,
    this.enabled = true,
    this.controller,
  }) : super(key: key);

  @override
  State<InternationalPhoneWidget> createState() => _InternationalPhoneWidgetState();
}

class _InternationalPhoneWidgetState extends State<InternationalPhoneWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        if (widget.title != null)
          Row(
            children: [
              Text(
                widget.title!,
                style: AppTextStyle.dmSans(
                  color: widget.titleColor ??
                      (isDark ? JAppColors.lightGray100 : JAppColors.darkGray800),
                  fontSize: 14.0,
                  weight: FontWeight.w500,
                ),
              ).tr(),
              if (widget.isRequired)
                Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),

        if (widget.title != null) const SizedBox(height: 8),

        // Phone Field
        IntlPhoneField(
          controller: _controller,
          enabled: widget.enabled,

          // Styling
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
            fontSize: 16.0,
            weight: FontWeight.w400,
          ),

          decoration: InputDecoration(
            hintText: widget.hintText ?? 'phoneNumber'.tr(),
            hintStyle: AppTextStyle.dmSans(
              color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray600,
              fontSize: 16.0,
              weight: FontWeight.w400,
            ),

            // Border styling
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark ? JAppColors.lightGray300 : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDark ? JAppColors.lightGray300 : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF7C3AED),
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),

            // Content styling
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            fillColor: widget.enabled
                ? (isDark ? JAppColors.darkGray800 : Colors.white)
                : (isDark ? JAppColors.darkGray700 : Colors.grey.shade100),
            filled: true,
          ),

          // Configuration
          initialCountryCode: widget.initialCountryCode ?? 'US',
          searchText: 'searchCountry'.tr(),
          invalidNumberMessage: 'invalidPhoneNumber'.tr(),

          // Country dropdown styling
          dropdownTextStyle: AppTextStyle.dmSans(
            color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
            fontSize: 14.0,
            weight: FontWeight.w400,
          ),

          flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 8),

          // Callbacks
          onChanged: (phone) {
            if (widget.onChanged != null) {
              widget.onChanged!(phone.completeNumber);
            }
          },

          onSubmitted: (value) {
            if (widget.onSubmitted != null) {
              widget.onSubmitted!(value);
            }
          },

        ),
      ],
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}


