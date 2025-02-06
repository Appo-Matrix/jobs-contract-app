import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_contracts/utils/common_widgets/main_button.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import '../../../../../utils/common_widgets/appbar.dart';
import '../../../../../utils/common_widgets/circular_shape.dart';
import '../../../../../utils/common_widgets/dotted_container_widget.dart';
import '../../../../../utils/common_widgets/file_picker_container_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/device/device_utility.dart';

class AddResumeScreen extends StatefulWidget {
  const AddResumeScreen({super.key});

  @override
  State<AddResumeScreen> createState() => _AddResumeScreenState();
}

class _AddResumeScreenState extends State<AddResumeScreen> {
  String? fileName;
  String? fileType;
  String? filePath;
  String? selectedDateTime;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        fileName = file.name; // Get file name
        fileType = file.extension ?? "Unknown"; // Get file type (extension)
        filePath = file.path; // Get file path
        selectedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
            .format(DateTime.now()); // Get current date & time
      });
    }

  }


  void deleteFile() {
    if (filePath != null) {
      File file = File(filePath!);
      if (file.existsSync()) {
        file.deleteSync(); // Delete the file
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text("File deleted successfully 🗑️"),
        // ));
      }
    }
    setState(() {
      fileName = null;
      fileType = null;
      filePath = null;
      selectedDateTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.addResume,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
            fontSize: JSizes.fontSizeLg,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: JCircularAvatar(
          isDark: isDark,
          radius: 50, // Modify the radius to make it larger
          child: Icon(
            CupertinoIcons.back,
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: [
            SizedBox(height: 20),
            fileName != null
                ? FilePickerContainerWidget(
                    isDark: isDark,
                    onTap: () {
                      deleteFile();
                    },
                    title: fileName!,
                    subTitle: selectedDateTime!,
                  )
                : doted_container_widget(
                    isDark: isDark,
                    onTap: () {
                      pickFile();
                    },
                  ),
            SizedBox(height: 20),
            Text(
              'Upload files in PDF format up to 5 MB. Just upload it once and you can use it in your next application.',
              style: AppTextStyle.dmSans(
                color:
                    isDark ? JAppColors.lightGray100 : JAppColors.darkGray1000,
                fontSize: JSizes.fontSizeESm,
                weight: FontWeight.w400,
              ),
            ),
            Spacer(),
            MainButton(
              btn_title: 'Save',
              btn_radius: 8,
              btn_color: JAppColors.primary,
              btn_boarder_color: Colors.transparent,
              title_color: Colors.white,
              image_value: false,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
