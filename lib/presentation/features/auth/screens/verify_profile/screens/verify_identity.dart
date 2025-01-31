import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import '../../../../../../utils/common_widgets/appbar.dart';
import '../../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/device/device_utility.dart';

class VerifyIdentity extends StatefulWidget {
  const VerifyIdentity({super.key});

  @override
  State<VerifyIdentity> createState() => _VerifyIdentityState();
}

class _VerifyIdentityState extends State<VerifyIdentity> {

  final TextEditingController _cnt = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  DateTime? _selectedDate;
  final TextEditingController _dobController = TextEditingController();
  late SingleValueDropDownController controller;

  final List<String> countries = [
    "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Argentina", "Armenia",
    "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados",
    "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina",
    "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cabo Verde"
  ];

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900), // set the first date that can be selected
      lastDate: DateTime.now(), // limit the date selection to today
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!); // Display formatted date
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = SingleValueDropDownController();
  }

  @override
  void dispose() {
    controller.dispose();
    _cnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.verifyIdentity,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20,
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ),
      bottomNavigationBar:               Padding(

        padding: const EdgeInsets.symmetric(vertical: 26,horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Verify OTP logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: JAppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              JText.next,
              style: AppTextStyle.dmSans(
                color: Colors.white,
                fontSize: 16.0,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(JText.details,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 20.0,
                  weight: FontWeight.w600,
                ),
              ),
              SizedBox(height: JSizes.spaceBtwSections - 10),
              TextFieldWidget(
                hintText: JText.enterPhoneNumber,
                subTitle: JText.fullName,
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray700,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                hintText: JText.enterPhoneNumber,
                subTitle: JText.fullName,
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray700,
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              TextFieldWidget(
                hintText: JText.enterPhoneNumber,
                subTitle: JText.fullName,
                subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.darkGray700,
              ),
              SizedBox(height: JSizes.spaceBtwSections - 10),
              Text(JText.country,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                ),
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              // The DropDownTextField widget
              DropDownTextField(
                controller: controller,
                clearOption: true,
                enableSearch: true,
                clearIconProperty: IconProperty(color: Colors.green),
                searchTextStyle: const TextStyle(color: Colors.red),
                searchDecoration: const InputDecoration(
                    hintText: "Enter your custom hint text here"),
                validator: (value) {
                  if (value == null) {
                    return "Please select a country"; // Updated validation message
                  } else {
                    return null;
                  }
                },
                dropDownList: countries.map((e) {
                  return DropDownValueModel(name: e, value: e);
                }).toList(),
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),

              Text(JText.dateOfBirth,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  fontSize: 16.0,
                  weight: FontWeight.w600,
                ),
              ),
              SizedBox(height: JSizes.spaceBtwInputFields),
              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      hintText: 'Select your date of birth',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _pickDate(context), // Open date picker when icon is tapped
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),


              SizedBox(height: JSizes.spaceBtwInputFields+40),



            ],
          ),
        ),
      ),
    );
  }
}
