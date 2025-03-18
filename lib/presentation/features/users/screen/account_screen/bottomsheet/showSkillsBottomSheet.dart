import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'JBottomSheet.dart';

void showSkillsBottomSheet(BuildContext context) {
  final searchController = TextEditingController();
  // Example selected skills
  final List<String> selectedSkills = ['Surface Repair', 'Ceiling', 'Plaster', 'mudding', 'Acoustic', 'Sanding'];

  JBottomSheet.show(
    context: context,
    title: 'Add Skills',
    subtitle: 'Add Your Skills & Expertise',
    content: Column(
      children: [
        // Search field
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search Skills',
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.close),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Skills chips
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: selectedSkills.map((skill) {
            return Chip(
              label: Text(skill),
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () {
                // Handle skill deletion
              },
              backgroundColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            );
          }).toList(),
        ),
      ],
    ),
    onSave: () {
      // Save skills
      Navigator.pop(context);
    },
  );
}