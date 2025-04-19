import 'dart:io';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_contracts/utils/constants/text_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../utils/constants/image_string.dart';

class SignatureSection extends StatefulWidget {
  final bool isDark;
  final TextEditingController signatureController;
  final Function(File?) onSignatureImageSelected;

  const SignatureSection({
    super.key,
    required this.isDark,
    required this.signatureController,
    required this.onSignatureImageSelected,
  });

  @override
  State<SignatureSection> createState() => _SignatureSectionState();
}

class _SignatureSectionState extends State<SignatureSection> {
  File? _signatureImage;
  final _imagePicker = ImagePicker();

  Future<void> _pickSignatureImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );

      if (pickedFile != null) {
        setState(() {
          _signatureImage = File(pickedFile.path);
          widget.onSignatureImageSelected(_signatureImage);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _removeSignatureImage() {
    setState(() {
      _signatureImage = null;
      widget.onSignatureImageSelected(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
      JText.eSignature,
          style: AppTextStyle.dmSans(
            color: widget.isDark ? JAppColors.lightGray300 : JAppColors.darkGray700,
            fontSize: JSizes.fontSizeMd,
            weight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        // Row with text input and upload box
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text signature input
            Expanded(
              flex: 3,
              child:
              TextFormField(
                controller: widget.signatureController,
                decoration: InputDecoration(
                  fillColor:  widget.isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
                  filled: true,
                  hintText: JText.typeSignatureHint,
                  hintStyle: AppTextStyle.dmSans(
                    color: widget.isDark ? JAppColors.lightGray300.withOpacity(0.5) : JAppColors.darkGray700.withOpacity(0.5),
                    fontSize: 14.0, weight: FontWeight.w500,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.isDark ? JAppColors.darkGray700 : JAppColors.lightGray300,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: widget.isDark ? JAppColors.darkGray700 : JAppColors.lightGray300,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: JAppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
                style: AppTextStyle.dmSans(
                  color: widget.isDark ? JAppColors.lightGray100 : JAppColors.darkGray800,
                  fontSize: JSizes.fontSizeMd,
                  weight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Upload box
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: _pickSignatureImage,
                child: Container(
                  height: 48, // Match TextFormField height
                  decoration: BoxDecoration(
                    color: widget.isDark ? JAppColors.backGroundDarkCard : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: widget.isDark ? JAppColors.darkGray700 : JAppColors.lightGray300,
                      width: 1,
                    ),
                  ),
                  child: _signatureImage == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        JImages.upload,
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          widget.isDark ? JAppColors.lightGray100 :JAppColors.darkGray800,
                          BlendMode.srcIn,

                        ),
                      ),


                    ],
                  )
                      : Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.file(
                          _signatureImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _removeSignatureImage,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: JAppColors.error400.withOpacity(0.8),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Helper text
        Text(
       JText.signatureHelperText,
          style: AppTextStyle.dmSans(
            color: widget.isDark ? JAppColors.lightGray300.withOpacity(0.7) : JAppColors.darkGray700.withOpacity(0.7),
            fontSize: 12.0,
            weight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}