import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'JBottomSheet.dart';

void showResumeBottomSheet(BuildContext context) {
  JBottomSheet.show(
    context: context,
    title: 'Add Resume',
    subtitle: 'Upload Your Resume.',
    content: Column(
      children: [
        // Upload container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Icon(Icons.upload_file, size: 32),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Implement file picker
                },
                child: const Text('Upload CV/Resume'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Help text
        Text(
          'Upload files in PDF format up to 5 MB. Just upload it once and you can use it in your next application.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    ),
    onSave: () {
      // Save resume
      Navigator.pop(context);
    }, backgroundColor: null,
  );
}