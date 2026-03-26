import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../data/models/experience/experience_req.dart';
import '../../providers/experience_provider.dart';
import 'JBottomSheet.dart';

Future<void> showWorkExperienceBottomSheet(BuildContext context, bool isDark) {
  final jobTitleController = TextEditingController();
  final companyController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();

  return JBottomSheet.show(
    context: context,
    title: JText.addWorkExperience,
    subtitle: JText.addWorkExperienceDesc,
    isDark: isDark,
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Job Title ──────────────────────────────────────────────────────
        TextFieldWidget(
          subTitle: JText.jobTitle,
          hintText: 'e.g. Sr Software Engineer',
          prefixIcon: Icons.work_outline,
          textEditingController: jobTitleController,
          isRequired: true,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),

        // ── Company ───────────────────────────────────────────────────────
        TextFieldWidget(
          subTitle: JText.company,
          hintText: 'e.g. TechCorp Ltd.',
          prefixIcon: Icons.business_outlined,
          textEditingController: companyController,
          isRequired: true,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),

        // ── Dates ─────────────────────────────────────────────────────────
        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                subTitle: JText.startDate,
                hintText: JText.startDate,
                textEditingController: startDateController,
                isRequired: true,
                readOnly: true,
                suffixIconData: Icons.calendar_today,
                onTap: () => _showCupertinoDate(context, startDateController),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFieldWidget(
                subTitle: JText.endDate,
                hintText: JText.endDate,
                textEditingController: endDateController,
                readOnly: true,
                suffixIconData: Icons.calendar_today,
                onTap: () => _showCupertinoDate(context, endDateController),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Description ───────────────────────────────────────────────────
        TextFieldWidget(
          subTitle: JText.description,
          hintText: JText.writeInformationDetail,
          textEditingController: descriptionController,
          maxLines: 4,
          textInputAction: TextInputAction.done,
        ),
      ],
    ),
    onSave: () async {
      if (jobTitleController.text.trim().isEmpty ||
          companyController.text.trim().isEmpty ||
          startDateController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all required fields')),
        );
        return;
      }

      final request = ExperienceRequest(
        jobTitle: jobTitleController.text.trim(),
        company: companyController.text.trim(),
        startDate: startDateController.text.trim(),
        endDate: endDateController.text.trim(),
        description: descriptionController.text.trim(),
      );

      // ✅ removed Navigator.pop — JBottomSheet handles it

      Navigator.pop(context);

      // ✅ Save then refresh list
      await context.read<ExperienceProvider>().createExperience(request);

      await context.read<ExperienceProvider>().loadExperiences();
    },
  );
}

// ── Cupertino date picker ─────────────────────────────────────────────────────

void _showCupertinoDate(
  BuildContext context,
  TextEditingController controller,
) {
  DateTime tempDate = DateTime.now();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => StatefulBuilder(
      builder: (ctx, setState) => SizedBox(
        height: 300,
        child: Column(
          children: [
            // ── Cancel / Done ──────────────────────────────────────────────
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
                        '${tempDate.year}-'
                        '${tempDate.month.toString().padLeft(2, '0')}-'
                        '${tempDate.day.toString().padLeft(2, '0')}';
                    Navigator.pop(context);
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
            // ── Picker ────────────────────────────────────────────────────
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: tempDate,
                minimumDate: DateTime(2000),
                maximumDate: DateTime(2101),
                onDateTimeChanged: (date) {
                  setState(() => tempDate = date);
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
