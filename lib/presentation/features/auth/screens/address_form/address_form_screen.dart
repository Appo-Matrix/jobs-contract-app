import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

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
                hintText: 'streetNumber',
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
                hintText: 'neighborhoodArea)',
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
                hintText: 'city',
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
                hintText: 'stateProvince',
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
                hintText: 'country',
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
                hintText: 'postalCode',
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
                            child:
                            Container(
                              padding: EdgeInsets.all(8),


                              decoration: BoxDecoration(
                                  color: JAppColors.primary
                                  ,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Row(
                                children: [

                                  SvgPicture.asset(
                                    JImages.locationSvg,
                                    width: 20,
                                    height: 20,
                                    colorFilter: ColorFilter.mode(
                                      isDark ? JAppColors.lightGray100 :JAppColors.primary,
                                      BlendMode.srcIn,

                                    ),
                                  ),


                                  SizedBox(width: 8,),
                                  Text(
                                    'traceMe',
                                    style: AppTextStyle.dmSans(
                                      color:
                                      isDark
                                          ? JAppColors.lightGray100
                                          : JAppColors.darkGray800,

                                      fontSize: 16.0,
                                      weight: FontWeight.w500,
                                    ),
                                  ).tr(),
                                ],
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
