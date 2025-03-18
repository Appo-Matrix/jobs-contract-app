import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'JBottomSheet.dart';

void showWorkExperienceBottomSheet(BuildContext context) {
  // Form controllers
  final jobTitleController = TextEditingController();
  final companyController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();

  JBottomSheet.show(
    context: context,
    title: 'Add Work Experience',
    subtitle: 'Highlight your skills and career growth by adding your past roles and achievements.',
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Job Title'),
        const SizedBox(height: 8),
        TextField(
          controller: jobTitleController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        const SizedBox(height: 16),
        const Text('Company'),
        const SizedBox(height: 8),
        TextField(
          controller: companyController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
        ),

        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Start Date'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: startDateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('End Date'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: endDateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
        const Text('Description'),
        const SizedBox(height: 8),
        TextField(
          controller: descriptionController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Write additional information here',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    ),
    onSave: () {
      // Save work experience
      Navigator.pop(context);
    },
  );
}