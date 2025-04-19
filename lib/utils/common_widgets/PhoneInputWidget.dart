import 'package:flutter/material.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

import '../constants/app_text_style.dart';
import '../constants/colors.dart';

class PhoneInputWidget extends StatefulWidget {
  final Function(String)? onPhoneChanged;
  final Function(String)? onCountryCodeChanged;
  final String? initialCountryCode;
  final bool isRequired;
  final String label;

  const PhoneInputWidget({
    Key? key,
    this.onPhoneChanged,
    this.onCountryCodeChanged,
    this.initialCountryCode = "US",
    this.isRequired = false,
    this.label = "Phone",
  }) : super(key: key);

  @override
  State<PhoneInputWidget> createState() => _PhoneInputWidgetState();
}

class _PhoneInputWidgetState extends State<PhoneInputWidget> {
  late String _selectedCountryCode;
  final TextEditingController _phoneController = TextEditingController();

  // Simple map of country codes - in a real app you'd have a more complete list
  final Map<String, String> _countryCodes = {
    "US": "+1",
    "UK": "+44",
    "CA": "+1",
    "IN": "+91",
    "AU": "+61",
  };

  @override
  void initState() {
    super.initState();
    _selectedCountryCode = widget.initialCountryCode ?? "US";
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = JDeviceUtils.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with required asterisk if needed
        Row(
          children: [
            Text(
              widget.label,
              style:  TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? JAppColors.lightGray100 : JAppColors.darkGray800
              ),
            ),
            if (widget.isRequired)
              Text(
                " *",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),

        // Phone input field with country code selector
        Container(
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              // Country code selector
              InkWell(
                onTap: () {
                  _showCountryCodePicker(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(

                    color: isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8) ,bottomLeft: Radius.circular(8)),
                    border: Border(

                      right: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedCountryCode,
                        style: AppTextStyle.dmSans(
                          color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                          fontSize: 16.0,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 24,
                        color: isDark ? JAppColors.lightGray100 : JAppColors.lightGray800,
                      ),
                    ],
                  ),
                ),
              ),

              // Phone number input
              Expanded(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(8))),
                  child: TextField(


                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration:  InputDecoration(
                      
                      fillColor:  isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
                      filled: true,
                      hintText: "Enter phone number",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onChanged: (value) {
                      if (widget.onPhoneChanged != null) {
                        widget.onPhoneChanged!(value);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCountryCodePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Country Code",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _countryCodes.length,
                itemBuilder: (context, index) {
                  final countryCode = _countryCodes.keys.elementAt(index);
                  final dialCode = _countryCodes.values.elementAt(index);

                  return ListTile(
                    title: Text("$countryCode ($dialCode)"),
                    onTap: () {
                      setState(() {
                        _selectedCountryCode = countryCode;
                      });
                      if (widget.onCountryCodeChanged != null) {
                        widget.onCountryCodeChanged!(countryCode);
                      }
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

