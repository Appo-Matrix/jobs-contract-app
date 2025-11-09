import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';

class DeliverContractDialog extends StatefulWidget {
  final bool isDark;

  const DeliverContractDialog({
    super.key,
    required this.isDark,
  });

  @override
  State<DeliverContractDialog> createState() => _DeliverContractDialogState();
}

class _DeliverContractDialogState extends State<DeliverContractDialog> {
  final TextEditingController _messageController = TextEditingController();
  PlatformFile? _selectedFile;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['svg', 'png', 'jpg', 'jpeg', 'gif'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = result.files.first;
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: widget.isDark ? JAppColors.darkGray800 : Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Deliver Contract',
                  style: AppTextStyle.dmSans(
                    fontSize: 20.0,
                    weight: FontWeight.w700,
                    color: widget.isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray900,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: widget.isDark
                        ? JAppColors.darkGray300
                        : JAppColors.lightGray700,
                  ),
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Attachment Section
            Text(
              'Attachment',
              style: AppTextStyle.dmSans(
                fontSize: 15.0,
                weight: FontWeight.w600,
                color: widget.isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray900,
              ),
            ),
            const SizedBox(height: 12),

            // Upload Area
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? JAppColors.darkGray700
                      : JAppColors.lightGray100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.isDark
                        ? JAppColors.darkGray600
                        : JAppColors.lightGray300,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: widget.isDark
                            ? JAppColors.darkGray800
                            : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.isDark
                              ? JAppColors.darkGray600
                              : JAppColors.lightGray300,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.upload_outlined,
                        size: 24,
                        color: widget.isDark
                            ? JAppColors.darkGray300
                            : JAppColors.lightGray700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Click to upload',
                            style: AppTextStyle.dmSans(
                              fontSize: 14.0,
                              color: JAppColors.primary,
                              weight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' or drag and drop',
                            style: AppTextStyle.dmSans(
                              fontSize: 14.0,
                              color: widget.isDark
                                  ? JAppColors.darkGray300
                                  : JAppColors.lightGray700,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SVG, PNG, JPG or GIF (max. 800×400px)',
                      style: AppTextStyle.dmSans(
                        fontSize: 12.0,
                        color: widget.isDark
                            ? JAppColors.darkGray400
                            : JAppColors.lightGray600,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Show selected file
            if (_selectedFile != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? JAppColors.darkGray700
                      : JAppColors.lightGray100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: widget.isDark
                        ? JAppColors.darkGray600
                        : JAppColors.lightGray300,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: JAppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.insert_drive_file,
                        size: 20,
                        color: JAppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedFile!.name,
                            style: AppTextStyle.dmSans(
                              fontSize: 14.0,
                              color: widget.isDark
                                  ? JAppColors.darkGray100
                                  : JAppColors.lightGray900,
                              weight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${(_selectedFile!.size / 1024).toStringAsFixed(0)} KB',
                            style: AppTextStyle.dmSans(
                              fontSize: 12.0,
                              color: widget.isDark
                                  ? JAppColors.darkGray400
                                  : JAppColors.lightGray600,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedFile = null;
                        });
                      },
                      icon: Icon(
                        Icons.close,
                        color: widget.isDark
                            ? JAppColors.darkGray400
                            : JAppColors.lightGray600,
                      ),
                      iconSize: 18,
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),

            // Leave a Message
            Text(
              'Leave a Message',
              style: AppTextStyle.dmSans(
                fontSize: 15.0,
                weight: FontWeight.w600,
                color: widget.isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray900,
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _messageController,
              maxLines: 5,
              style: AppTextStyle.dmSans(
                fontSize: 14.0,
                color: widget.isDark
                    ? JAppColors.darkGray100
                    : JAppColors.lightGray900, weight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'The work is done...',
                hintStyle: AppTextStyle.dmSans(
                  fontSize: 14.0,
                  color: widget.isDark
                      ? JAppColors.darkGray500
                      : JAppColors.lightGray500,
                  weight: FontWeight.w400,
                ),
                filled: true,
                fillColor: widget.isDark
                    ? JAppColors.darkGray700
                    : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: widget.isDark
                        ? JAppColors.darkGray600
                        : JAppColors.lightGray300,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: widget.isDark
                        ? JAppColors.darkGray600
                        : JAppColors.lightGray300,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: JAppColors.primary,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: widget.isDark
                          ? JAppColors.darkGray300
                          : JAppColors.lightGray700,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(
                        color: widget.isDark
                            ? JAppColors.darkGray600
                            : JAppColors.lightGray300,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: widget.isDark
                          ? JAppColors.darkGray700
                          : JAppColors.lightGray100,
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyle.dmSans(
                        fontSize: 16.0,
                        weight: FontWeight.w600,
                        color: widget.isDark
                            ? JAppColors.darkGray300
                            : JAppColors.lightGray700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle delivery
                      Navigator.pop(context, {
                        'file': _selectedFile,
                        'message': _messageController.text,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: JAppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Deliver Now',
                      style: AppTextStyle.dmSans(
                        fontSize: 16.0,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}