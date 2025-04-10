import 'package:flutter/material.dart';
import 'package:job_contracts/presentation/features/users/myads/widgets/file_upload_widget.dart';
import 'dart:io';
import '../../../../utils/common_widgets/appbar.dart';
import '../../../../utils/common_widgets/back_circle.dart';
import '../../../../utils/common_widgets/main_button.dart';
import '../../../../utils/constants/app_text_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../routes/app_routes.dart';

class AdUploadScreen extends StatefulWidget {
  const AdUploadScreen({super.key});

  @override
  State<AdUploadScreen> createState() => _AdUploadScreenState();
}

class _AdUploadScreenState extends State<AdUploadScreen> {
  List<File> selectedImages = [];
  List<File> selectedVideos = [];

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? JAppColors.darkGray800 : Colors.white,
      appBar: JAppbar(
        title: Text(
          JText.createAd,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ),
        leadingIcon: BackCircle(
          isDark: isDark,
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upload Images Section
              FileUploadWidget(
                title: JText.uploadImages,
                selectedFiles: selectedImages,
                onFilesSelected: (files) {
                  setState(() {
                    selectedImages = files;
                  });
                }, type: JText.fileFormats,
              ),

              const SizedBox(height: 24),

              // Upload Videos Section
              FileUploadWidget(
                title: JText.uploadVideos,
                selectedFiles: selectedVideos,
                onFilesSelected: (files) {
                  setState(() {
                    selectedVideos = files;
                  });
                },
                isVideo: true, type: JText.videoFormats,
              ),

              const SizedBox(height: 32),



              MainButton(
                btn_title: JText.next,
                btn_radius: 10,
                btn_color: JAppColors.main,
                btn_boarder_color: Color(0xff7030F1),
                title_color: Colors.white,
                text_fontweight: FontWeight.w600,
                image_value: false,onTap: (){

                AppRouter.router.push('/adDetailsScreen');

              },
              ),
              SizedBox(height: JSizes.spaceBtwItems),
              MainButton(
                btn_title: JText.moveToDrafts,
                btn_radius: 10,
                btn_color: Colors.transparent,
                btn_boarder_color: JAppColors.t,
                title_color: isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray800,
                text_fontweight: FontWeight.w600,
                onTap: (){},

                text_size: JSizes.fontSizeMd, image_value: false,
              ),
              // Move to Drafts Button

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}