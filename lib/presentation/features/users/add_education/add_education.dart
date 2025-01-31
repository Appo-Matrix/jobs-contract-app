import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/add_education/searchable_bottomsheet_content.dart';
import 'package:job_contracts/presentation/features/users/add_education/widgets/text_title_education_widget.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({super.key});

  @override
  State<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  bool isChecked = false; // Add this inside your State class
  bool isSecondButtonVisible = false; // Track visibility of second button
  bool isSaveButtonVisible = true; // Track visibility of the Save button

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          JText.addEducation,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align left
            children: [
              GestureDetector(
                  onTap: (){

                    showSearchableEducationBottomSheet(context, isDark, JText.levelOfEducation);
                  },
                  child: TextTitleEducationWidget(isDark: isDark, title: JText.levelOfEducation, education: 'ae',)),

              SizedBox(height: JSizes.spaceBtwInputFields + 8),
              TextTitleEducationWidget(isDark: isDark, title: JText.institutionName, education: 'ae',),

              SizedBox(height: JSizes.spaceBtwInputFields + 8),

              TextTitleEducationWidget(isDark: isDark, title: JText.fieldOfStudy, education: 'ae',),
              SizedBox(height: JSizes.spaceBtwInputFields + 8), // Spacing

              TextTitleEducationWidget(
                maxLines: 5,
                isDark: isDark, title: JText.fieldOfStudy, education: 'My name is basit murad I am mobile app developerI will develop mibile app fro andori dand io i am backed develoep rwiht  year of aasfa hdfjjdsfdf9 ',),
              SizedBox(height: JSizes.spaceBtwInputFields + 8), // Spacing

              Row(
                children: [
                  Expanded(
                      child: TextTitleEducationWidget(isDark: isDark, title: JText.startDate, education: 'education')
                  ),
                  const SizedBox(width: 16), // Space between columns

                  Expanded(
                      child: TextTitleEducationWidget(isDark: isDark, title: JText.endDate, education: 'education')
                  ),
                ],
              ),

              SizedBox(height: JSizes.spaceBtwInputFields + 8), // Spacing

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: JAppColors.primary,
                    onChanged: (bool? value) {
                      setState(() {
                        isSecondButtonVisible = true; // Show second button
                      });
                    },
                  ),
                  Text(
                    JText.positionNow,
                    style: AppTextStyle.dmSans(
                      color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                      fontSize: 14.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: JSizes.spaceBtwInputFields + 8), // Spacing

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isSaveButtonVisible = false; // Hide the Save button
                            isSecondButtonVisible = true; // Show the Remove button
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: JAppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          JText.save,
                          style: AppTextStyle.dmSans(
                            color: Colors.white,
                            fontSize: 16.0,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: JSizes.spaceBtwInputFields),

                  // If the Save button is hidden, show the Remove button
                  if (isSecondButtonVisible)
                    Expanded(
                      child: SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            showBottomSheet(context, isDark); // Show the bottom sheet on button click
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: JAppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            JText.remove,
                            style: AppTextStyle.dmSans(
                              color: Colors.white,
                              fontSize: 16.0,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSearchableEducationBottomSheet(BuildContext context, bool isDark, String educationText) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (context) {
        return SearchableBottomSheetContent(isDark: isDark, educationText: educationText);
      },
    );
  }


  void showBottomSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Ensures the bottom sheet takes minimum space needed
            children: [
              SizedBox(height: JSizes.spaceBtwSections + 10),

              // Title
              Text(
                JText.unDoChanges,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 20.0,
                  weight: FontWeight.w600,
                ),
              ),
              SizedBox(height: JSizes.spaceBtwInputFields), // Adds space after title

              // Subtitle
              Text(
                JText.changeEnterText,
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 16.0,
                  weight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: JSizes.spaceBtwSections + 15), // Adds space after subtitle

              // First Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // setState(() {
                    //   isSecondButtonVisible = true; // Show second button
                    // });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: JAppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    JText.continueFilling,
                    style: AppTextStyle.dmSans(
                      color: Colors.white,
                      fontSize: 16.0,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: JSizes.spaceBtwSections - 10), // Adds space between buttons

              // Second Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // setState(() {
                    //   isSecondButtonVisible = true; // Show second button
                    // });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: JAppColors.primary.withOpacity(0.4),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide.none, // Removes the border stroke
                    ),
                    elevation: 0,
                  ),

                  child: Text(
                    JText.undoChanges,
                    style: AppTextStyle.dmSans(
                      color: Colors.white,
                      fontSize: 16.0,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: JSizes.spaceBtwSections + 20), // Adds final space after the buttons
            ],
          ),
        );
      },
    );
  }

}



