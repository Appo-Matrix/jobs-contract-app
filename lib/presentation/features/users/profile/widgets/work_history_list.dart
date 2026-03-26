import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/experience/work_experience.dart';
import '../../../../../presentation/features/users/providers/experience_provider.dart';
import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../account_screen/bottomsheet/showCupertinoDatePicker.dart';

class WorkHistoryList extends StatelessWidget {
  final bool isDark;

  const WorkHistoryList({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final provider    = context.watch<ExperienceProvider>();
    final experiences = provider.experiences;
    final isLoading   = provider.isLoading;
    final error       = provider.error;

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

    if (experiences.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'No work history added yet.',
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
      children: experiences
          .map((exp) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: WorkHistoryItem(isDark: isDark, experience: exp),
      ))
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class WorkHistoryItem extends StatelessWidget {
  final bool isDark;
  final WorkExperience experience;

  const WorkHistoryItem({
    super.key,
    required this.isDark,
    required this.experience,
  });

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      return DateTime.parse(date).year.toString();
    } catch (_) {
      return date.length >= 4 ? date.substring(0, 4) : date;
    }
  }

  String get _period {
    final start = _formatDate(experience.startDate);
    final end   = _formatDate(experience.endDate);
    if (end.isEmpty) return '$start - Present';
    return '$start - $end';
  }

  // ── Delete ─────────────────────────────────────────────────────────────────
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Experience'),
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
                  .read<ExperienceProvider>()
                  .deleteExperience(experience.id);
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

  // ── Edit ───────────────────────────────────────────────────────────────────
  void _showEditSheet(BuildContext context) {
    final jobTitleController    = TextEditingController(text: experience.jobTitle);
    final companyController     = TextEditingController(text: experience.company);
    final startDateController   = TextEditingController(text: experience.startDate);
    final endDateController     = TextEditingController(text: experience.endDate);
    final descriptionController = TextEditingController(text: experience.description);

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────────────
              Text(
                'Edit Work Experience',
                style: AppTextStyle.dmSans(
                  fontSize: 18.0,
                  weight: FontWeight.w700,
                  color: isDark
                      ? JAppColors.darkGray100
                      : JAppColors.lightGray800,
                ),
              ),
              const SizedBox(height: 20),

              // ── Job Title ────────────────────────────────────────────────────
              TextFieldWidget(
                subTitle: 'Job Title',
                hintText: 'e.g. Sr Software Engineer',
                prefixIcon: Icons.work_outline,
                textEditingController: jobTitleController,
                isRequired: true,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // ── Company ──────────────────────────────────────────────────────
              TextFieldWidget(
                subTitle: 'Company',
                hintText: 'e.g. TechCorp Ltd.',
                prefixIcon: Icons.business_outlined,
                textEditingController: companyController,
                isRequired: true,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // ── Dates ────────────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      subTitle: 'Start Date',
                      hintText: 'Start Date',
                      textEditingController: startDateController,
                      isRequired: true,
                      readOnly: true,
                      suffixIconData: Icons.calendar_today,
                      onTap: () => showCupertinoDatePicker(
                        context,
                        startDateController,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFieldWidget(
                      subTitle: 'End Date',
                      hintText: 'End Date',
                      textEditingController: endDateController,
                      readOnly: true,
                      suffixIconData: Icons.calendar_today,
                      onTap: () => showCupertinoDatePicker(
                        context,
                        endDateController,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ── Description ──────────────────────────────────────────────────
              TextFieldWidget(
                subTitle: 'Description',
                hintText: 'Describe your role and responsibilities',
                textEditingController: descriptionController,
                maxLines: 4,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),

              // ── Save ─────────────────────────────────────────────────────────
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
                    if (jobTitleController.text.trim().isEmpty ||
                        companyController.text.trim().isEmpty ||
                        startDateController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all required fields'),
                        ),
                      );
                      return;
                    }

                    final data = {
                      'jobTitle':    jobTitleController.text.trim(),
                      'company':     companyController.text.trim(),
                      'startDate':   startDateController.text.trim(),
                      'endDate':     endDateController.text.trim(),
                      'description': descriptionController.text.trim(),
                    };

                    Navigator.pop(ctx);
                    await context
                        .read<ExperienceProvider>()
                        .updateExperience(experience.id, data);
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
                  experience.jobTitle,
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
                  experience.company,
                  style: AppTextStyle.dmSans(
                    fontSize: JSizes.fontSizeSm,
                    weight: FontWeight.normal,
                    color: isDark
                        ? JAppColors.darkGray300
                        : JAppColors.lightGray600,
                  ),
                ),
                if (experience.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    experience.description,
                    style: AppTextStyle.dmSans(
                      fontSize: JSizes.fontSizeSm,
                      weight: FontWeight.normal,
                      color: isDark
                          ? JAppColors.darkGray300
                          : JAppColors.lightGray600,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ── Actions ───────────────────────────────────────────────────────
          Column(
            children: [
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