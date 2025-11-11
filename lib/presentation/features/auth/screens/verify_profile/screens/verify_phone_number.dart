  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:job_contracts/utils/constants/sizes.dart';

  import '../../../../../../utils/common_widgets/appbar.dart';
  import '../../../../../../utils/common_widgets/circular_shape.dart';
  import '../../../../../../utils/common_widgets/main_button.dart';
  import '../../../../../../utils/common_widgets/international_phone_widget.dart';
  import '../../../../../../utils/constants/app_text_style.dart';
  import '../../../../../../utils/constants/colors.dart';
  import '../../../../../../utils/constants/text_strings.dart';
  import '../../../../../../utils/device/device_utility.dart';
  import '../../../../../routes/app_routes.dart';

  class VerifyPhoneNumber extends StatefulWidget {
    const VerifyPhoneNumber({super.key});

    @override
    State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
  }

  class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
    final TextEditingController _phoneController = TextEditingController();

    bool _isLoading = false;
    String _phoneNumber = '';

    @override
    void dispose() {
      _phoneController.dispose();
      super.dispose();
    }

    void _sendOtp() async {
      if (_phoneNumber.isEmpty || _phoneNumber.length < 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid phone number'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OTP sent to $_phoneNumber'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to OTP verification screen
        AppRouter.router.push('/verifyPhoneOtp');
      }
    }

    @override
    Widget build(BuildContext context) {
      final isDark = JDeviceUtils.isDarkMode(context);

      return Scaffold(
        appBar: JAppbar(
          title: Text(
            JText.verifyPhoneNumber,
            style: AppTextStyle.dmSans(
              color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
              fontSize: 18.0,
              weight: FontWeight.w600,
            ),


          ),
          leadingIcon: Icon(Icons.arrow_back),
          leadingOnPressed: () {
            Navigator.pop(context);
          },

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Message
                Text(
                  'Verify Your Phone Number',
                  style: AppTextStyle.dmSans(
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                    fontSize: 24.0,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12),

                // Description
                Text(
                  'Enter your phone number to receive a verification code',
                  style: AppTextStyle.dmSans(
                    color: isDark
                        ? JAppColors.darkGray300
                        : JAppColors.lightGray600,
                    fontSize: 14.0,
                    weight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: JSizes.spaceBtwSections + 10),

                // Phone Number Field
                InternationalPhoneWidget(
                  title: 'Phone Number',
                  hintText: 'Enter your phone number',
                  initialCountryCode: '+92',
                  controller: _phoneController,
                  isRequired: true,
                  enabled: !_isLoading,
                  titleColor: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray900,
                  onChanged: (phoneNumber) {
                    setState(() {
                      _phoneNumber = phoneNumber;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length < 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),

                SizedBox(height: JSizes.spaceBtwInputFields + 20),

                // Info Box
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? JAppColors.primary.withOpacity(0.1)
                        : JAppColors.lightGray100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: JAppColors.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: JAppColors.primary,
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'You will receive a 6-digit verification code on this number',
                          style: AppTextStyle.dmSans(
                            color: isDark
                                ? JAppColors.darkGray200
                                : JAppColors.lightGray700,
                            fontSize: 13.0,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: JSizes.spaceBtwInputFields + 20),

                // Send OTP Button
                MainButton(
                  onTap: _isLoading ? null : _sendOtp,
                  btn_title: _isLoading ? 'Sending...' : 'Send OTP',
                  btn_radius: 10,
                  btn_color: JAppColors.main,
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                ),

                SizedBox(height: 24),

                // Help Text
                Center(
                  child: Text(
                    'Make sure you have access to this phone number',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.dmSans(
                      color: isDark
                          ? JAppColors.darkGray400
                          : JAppColors.lightGray500,
                      fontSize: 12.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }