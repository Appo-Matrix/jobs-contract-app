import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/routes/app_routes.dart';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/circular_shape.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<String> selectedLanguages = [];

  @override
  void initState() {
    super.initState();
    // Check if languages are selected
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLanguages();
    });
  }

  void checkLanguages() {
    if (selectedLanguages.isEmpty) {
      showNoLanguageDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {


    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,

      appBar: JAppbar(
        title: Text(
          JText.language,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 20, // Modify the radius to make it larger
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: selectedLanguages.isEmpty
                ? Center(
              child: Text(
                'No languages selected',
                style: AppTextStyle.dmSans(
                  color: Colors.grey,
                  fontSize: 16.0, weight: FontWeight.w500,
                ),
              ),
            )
                : ListView.builder(
              itemCount: selectedLanguages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedLanguages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MainButton(
              btn_title: "Add Language",
              btn_radius: 8,
              btn_color: const Color(0xff7030F1),
              btn_boarder_color: const Color(0xff7030F1),
              title_color: Colors.white,
              image_value: false,
              onTap: () {
                AppRouter.router.push('/languageSelectionScreen');


                // Navigate to language selection screen
              },
            ),
          ),
        ],
      ),
    );
  }

  // No Language Dialog
  void showNoLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dialog header indicator
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),

                // Warning icon
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange.shade700,
                    size: 35,
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  "No Language Selected",
                  style: AppTextStyle.dmSans(
                    color: Colors.black,
                    fontSize: 18.0,
                    weight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),

                // Description
                Text(
                  "Please add at least one language to continue. Language selection is required for proper functioning of the app.",
                  style: AppTextStyle.dmSans(
                    color: Colors.grey.shade700,
                    fontSize: 14.0,
                    weight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),

                // Add Language Button
                MainButton(
                  btn_title: "Add Language",
                  btn_radius: 8,
                  btn_color: const Color(0xff7030F1),
                  btn_boarder_color: const Color(0xff7030F1),
                  title_color: Colors.white,
                  image_value: false,
                  onTap: () {
                    // Navigator.of(context).pop();

                    AppRouter.router.push('/languageSelectionScreen');
                  },
                ),
                const SizedBox(height: 12),

                // Cancel Button
                MainButton(
                  btn_title: "Cancel",
                  btn_radius: 8,
                  btn_color: Colors.white,
                  btn_boarder_color: Colors.grey.shade300,
                  title_color: Colors.grey.shade700,
                  image_value: false,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}