import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/education/education_model.dart';
import '../../../../../data/models/education/user_education_model.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../providers/qualification_provider.dart';

class EducationList extends StatelessWidget {
  final bool isDark;

  const EducationList({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final provider   = context.watch<QualificationProvider>();
    final educations = provider.myQualifications;
    final isLoading  = provider.isLoading;
    final error      = provider.errorMessage;

    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (error != null) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          error,
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.w400,
            color: JAppColors.error600,
          ),
        ),
      );
    }

    if (educations.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'No education added yet.',
          style: AppTextStyle.dmSans(
            fontSize: JSizes.fontSizeSm,
            weight: FontWeight.w400,
            color: isDark ? JAppColors.darkGray300 : JAppColors.lightGray600,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: educations
          .map((edu) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: EducationItem(isDark: isDark, education: edu),
      ))
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class EducationItem extends StatelessWidget {
  final bool isDark;
  final UserEducationModel education;

  const EducationItem({
    super.key,
    required this.isDark,
    required this.education,
  });

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      final parsed = DateTime.parse(date);
      return parsed.year.toString();
    } catch (_) {
      return date.length >= 4 ? date.substring(0, 4) : date;
    }
  }

  String get _period {
    final start = _formatDate(education.startDate);
    final end   = _formatDate(education.endDate);
    if (education.isCurrentPosition || end.isEmpty) return '$start - Present';
    return '$start - $end';
  }

  // ── Delete confirmation dialog ─────────────────────────────────────────────
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Education'),
        content: const Text('Are you sure you want to delete this entry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await context
                  .read<QualificationProvider>()
                  .deleteQualification(education.id);
              await context
                  .read<QualificationProvider>()
                  .fetchMyQualifications();
            },
            child: Text(
              'Delete',
              style: TextStyle(color: JAppColors.error600),
            ),
          ),
        ],
      ),
    );
  }

  // ── Edit bottom sheet ──────────────────────────────────────────────────────
  void _showEditSheet(BuildContext context) {
    final degreeController      = TextEditingController(text: education.degree);
    final institutionController = TextEditingController(text: education.institutionName);
    final startDateController   = TextEditingController(text: education.startDate);
    final endDateController     = TextEditingController(text: education.endDate);
    bool isCurrentPosition      = education.isCurrentPosition;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? JAppColors.backGroundDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ────────────────────────────────────────────────────
                Text(
                  'Edit Education',
                  style: AppTextStyle.dmSans(
                    fontSize: 18.0,
                    weight: FontWeight.w700,
                    color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray800,
                  ),
                ),
                const SizedBox(height: 20),
            
                // ── Degree ────────────────────────────────────────────────────
                _buildField(
                  label: 'Degree',
                  controller: degreeController,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
            
                // ── Institution ───────────────────────────────────────────────
                _buildField(
                  label: 'Institution Name',
                  controller: institutionController,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
            
                // ── Dates ─────────────────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _buildDateField(
                        context: context,
                        label: 'Start Date',
                        controller: startDateController,
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDateField(
                        context: context,
                        label: 'End Date',
                        controller: endDateController,
                        isDark: isDark,
                        enabled: !isCurrentPosition,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
            
                // ── Currently studying toggle ──────────────────────────────────
                Row(
                  children: [
                    Switch(
                      value: isCurrentPosition,
                      activeColor: JAppColors.primary,
                      onChanged: (val) {
                        setState(() {
                          isCurrentPosition = val;
                          if (val) endDateController.clear();
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Currently studying here',
                      style: AppTextStyle.dmSans(
                        fontSize: 14.0,
                        weight: FontWeight.w500,
                        color: isDark
                            ? JAppColors.lightGray300
                            : JAppColors.darkGray700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
            
                // ── Save button ───────────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: JAppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      if (degreeController.text.trim().isEmpty ||
                          institutionController.text.trim().isEmpty ||
                          startDateController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all required fields'),
                          ),
                        );
                        return;
                      }
            
                      // ✅ Build updated model
                      final updated = EducationModel(
                        id:                education.id,
                        degree:            degreeController.text.trim(),
                        institutionName:   institutionController.text.trim(),
                        startDate:         startDateController.text.trim(),
                        endDate:           isCurrentPosition ? '' : endDateController.text.trim(),
                        isCurrentPosition: isCurrentPosition,
                      );
            
                      Navigator.pop(ctx);
            
                      await context
                          .read<QualificationProvider>()
                          .updateQualification(education.id, updated);
                      await context
                          .read<QualificationProvider>()
                          .fetchMyQualifications();
                    },
                    child: Text(
                      'Save Changes',
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
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? JAppColors.backGroundDarkCard
            : JAppColors.lightGray100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Content ───────────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _period,
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeSm,
                    weight: FontWeight.w500,
                    color: JAppColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  education.degree ?? '',
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeSm,
                    weight: FontWeight.w600,
                    color: isDark
                        ? JAppColors.darkGray100
                        : JAppColors.lightGray800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  education.institutionName ?? '',
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeSm,
                    weight: FontWeight.normal,
                    color: isDark
                        ? JAppColors.darkGray300
                        : JAppColors.lightGray600,
                  ),
                ),
              ],
            ),
          ),

          // ── Edit / Delete actions ─────────────────────────────────────────
          Column(
            children: [
              // Edit
              IconButton(
                onPressed: () => _showEditSheet(context),
                icon: Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.darkGray500,
                ),
              ),
              // Delete
              IconButton(
                onPressed: () => _confirmDelete(context),
                icon: Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: JAppColors.error600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Shared field helpers ───────────────────────────────────────────────────────

Widget _buildField({
  required String label,
  required TextEditingController controller,
  required bool isDark,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.dmSans(
            fontSize: 14.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray700,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );

Widget _buildDateField({
  required BuildContext context,
  required String label,
  required TextEditingController controller,
  required bool isDark,
  bool enabled = true,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.dmSans(
            fontSize: 14.0,
            weight: FontWeight.w600,
            color: isDark ? JAppColors.lightGray300 : JAppColors.darkGray700,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          readOnly: true,
          onTap: enabled
              ? () => _pickDate(context, controller)
              : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: Icon(
              Icons.calendar_today,
              size: 18,
              color: isDark ? Colors.white54 : JAppColors.lightGray500,
            ),
          ),
        ),
      ],
    );

void _pickDate(BuildContext context, TextEditingController controller) {
  DateTime tempDate = DateTime.now();
  showModalBottomSheet(
    context: context,
    builder: (_) => SizedBox(
      height: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  controller.text =
                  '${tempDate.year}-${tempDate.month.toString().padLeft(2, '0')}-${tempDate.day.toString().padLeft(2, '0')}';
                  Navigator.pop(context);
                },
                child: const Text('Done'),
              ),
            ],
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: tempDate,
              minimumDate: DateTime(2000),
              maximumDate: DateTime(2101),
              onDateTimeChanged: (date) => tempDate = date,
            ),
          ),
        ],
      ),
    ),
  );
}