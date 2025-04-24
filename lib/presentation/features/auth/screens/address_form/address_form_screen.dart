import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../routes/app_routes.dart';
import '../Login/widgets/login_header.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({super.key});

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _streetController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _postalCodeController = TextEditingController();

  // Map-related variables
  // GoogleMapController? _mapController;
  // LatLng _currentPosition = const LatLng(-37.8136, 144.9631); // Default Melbourne
  // bool _hasSetLocation = false;

  @override
  void dispose() {
    _streetController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
    // _mapController?.dispose();
    super.dispose();
  }

  void _onTraceMe() {
    // Here you would implement location tracing functionality
    // setState(() {
    //   _hasSetLocation = true;
    // });
    print('Trace Me button pressed');
  }

  void _onNextStep() {
    // if (_formKey.currentState?.validate() == true && _hasSetLocation) {
    //   // Proceed to next step
    //   print('Form is valid, proceeding to next step');
    // } else {
    //   // Show validation errors
    //   print('Form validation failed');
    // }
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return JText.requiredField;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: JSizes.appBarHeight,
              ),
              TopHeader(
                logo: JImages.mainLogo,
                title: 'address',
                subTitle: '',
                isDark: isDark,
              ),

              TextFieldWidget(
                subTitle: 'streetNumber',
                hintText: 'Enter street and number',
                textEditingController: _streetController,
                subtitleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              // Neighborhood Area Field
              TextFieldWidget(
                subTitle: 'neighborhoodArea',
                hintText: 'Enter neighborhood (optional)',
                textEditingController: _neighborhoodController,
                subtitleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              // City Field (Required)
              TextFieldWidget(
                subTitle: 'city',
                hintText: 'Enter city',
                textEditingController: _cityController,
                subtitleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              // State/Province Field (Required)
              TextFieldWidget(
                subTitle: 'stateProvince',
                hintText: 'Enter state or province',
                textEditingController: _stateController,
                subtitleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              // Country Field (Required)
              TextFieldWidget(
                subTitle: 'country',
                hintText: 'Enter country',
                textEditingController: _countryController,
                subtitleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              // Postal Code Field (Required)
              TextFieldWidget(
                subTitle: 'postalCode',
                hintText: 'Enter postal code',
                textEditingController: _postalCodeController,
                subtitleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                titleColor:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                isRequired: true,
                validator: _validateRequired,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              // Map Location (Required)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'mapLocation'.tr(),
                      style: AppTextStyle.dmSans(
                        color: isDark
                            ? JAppColors.lightGray100
                            : JAppColors.darkGray800,
                        fontSize: 16.0,
                        weight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: AppTextStyle.dmSans(
                            color: JAppColors.error600,
                            fontSize: 16.0,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark
                            ? JAppColors.darkGray700
                            : JAppColors.lightGray300,
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        children: [
                          // GoogleMap(
                          //   initialCameraPosition: CameraPosition(
                          //     target: _currentPosition,
                          //     zoom: 13,
                          //   ),
                          //   onMapCreated: (controller) {
                          //     _mapController = controller;
                          //   },
                          //   markers: {
                          //     Marker(
                          //       markerId: const MarkerId('currentLocation'),
                          //       position: _currentPosition,
                          //     ),
                          //   },
                          //   myLocationEnabled: true,
                          //   myLocationButtonEnabled: false,
                          //   zoomControlsEnabled: false,
                          //   mapToolbarEnabled: false,
                          //   onTap: (latLng) {
                          //     setState(() {
                          //       _currentPosition = latLng;
                          //       _hasSetLocation = true;
                          //     });
                          //   },
                          // ),
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: ElevatedButton.icon(
                              onPressed: _onTraceMe,
                              icon: const Icon(Icons.location_on),
                              label: Text(
                                'traceMe',
                                style: AppTextStyle.dmSans(
                                  color: JAppColors.error600,
                                  fontSize: 16.0,
                                  weight: FontWeight.w500,
                                ),
                              ).tr(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: JAppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 2,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // if (!_hasSetLocation)
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 8),
                  //     child: Text(
                  //       'Please select a location on the map',
                  //       style: AppTextStyle.dmSans(
                  //         color: JAppColors.error600,
                  //         fontSize: 12.0, weight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),

              const SizedBox(height: 40),
              MainButton(
                  btn_title: 'nextStep',
                  btn_radius: 10,
                  btn_color: JAppColors.main,
                  btn_boarder_color: Color(0xff7030F1),
                  title_color: Colors.white,
                  text_fontweight: FontWeight.w600,
                  image_value: false,
                  onTap: () {
                    AppRouter.router.push('/termsConditionsScreen');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
