import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_contracts/utils/constants/image_string.dart';
import 'dart:io';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';


class FileUploadWidget extends StatefulWidget {
  final String title;
  final List<File> selectedFiles;
  final Function(List<File>) onFilesSelected;
  final bool isVideo;
  final String type;

  const FileUploadWidget({
    Key? key,
    required this.title,
    required this.selectedFiles,
    required this.onFilesSelected,
    this.isVideo = false, required this.type,
  }) : super(key: key);

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  Future<void> _pickFiles() async {

    await Future.delayed(const Duration(milliseconds: 500));

    // Mock file added to the list
    final List<File> updatedFiles = List.from(widget.selectedFiles);

    widget.onFilesSelected(updatedFiles);
  }

  void _removeFile(int index) {
    final List<File> updatedFiles = List.from(widget.selectedFiles);
    updatedFiles.removeAt(index);
    widget.onFilesSelected(updatedFiles);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);
    final secondaryTextColor = isDark ? JAppColors.lightGray300 : JAppColors.darkGray500;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
            fontSize: 16.0,
            weight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),

        // Upload area
        InkWell(
          onTap: _pickFiles,
          child:                 Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? JAppColors.darkGray600
                    : JAppColors.lightGray300,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: isDark ? JAppColors.lightGray200 : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        JImages.upload,
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          JAppColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),


                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: JText.clickToUpload,
                          style: AppTextStyle.dmSans(
                            color: isDark ? Colors.white :JAppColors.darkGray800,
                            fontSize: 16.0,
                            weight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: JText.orDragAndDrop,
                          style: AppTextStyle.dmSans(
                            color: secondaryTextColor,
                            fontSize: 16.0,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.type,
                    style: AppTextStyle.dmSans(
                      color: secondaryTextColor,
                      fontSize: 14.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),


        ),

        // File preview grid
        if (widget.selectedFiles.isNotEmpty) ...[
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              widget.selectedFiles.length,
                  (index) => Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(JImages.image), // Replace with actual file preview
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: InkWell(
                      onTap: () => _removeFile(index),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: JAppColors.primary.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}