import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../utils/constants/app_text_style.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../data/models/education/qualification_request.dart';
import '../../providers/qualification_provider.dart';
import 'JBottomSheet.dart';

Future<void> showEducationBottomSheet(BuildContext context) {
  final universityController = TextEditingController();
  final degreeController     = TextEditingController();
  final startDateController  = TextEditingController();
  final endDateController    = TextEditingController();

  final bool isDark = JDeviceUtils.isDarkMode(context);
  bool isCurrentPosition = false;

  return JBottomSheet.show(
    context: context,
    title: JText.education,
    subtitle: JText.educationSubtitle,
    isDark: isDark,
    content: StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Degree ──────────────────────────────────────────────────────────
          TextFieldWidget(
            subTitle: JText.degree,
            hintText: JText.exBBA,
            prefixIcon: Icons.card_membership,
            textEditingController: degreeController,
            isRequired: true,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),

          // ── Institution Name ─────────────────────────────────────────────────
          TextFieldWidget(
            subTitle: JText.universityName,
            hintText: JText.universityName,
            prefixIcon: Icons.school,
            textEditingController: universityController,
            isRequired: true,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),

          // ── Start & End Date ─────────────────────────────────────────────────
// ── Start & End Date ─────────────────────────────────────────────────
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
                  onTap: isCurrentPosition
                      ? null
                      : () => _showCupertinoDate(context, endDateController),
                ),
              ),
            ],
          ),          const SizedBox(height: 12),

          // ── Currently Studying Toggle ────────────────────────────────────────
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
        ],
      ),
    ),
    onSave: () async {
      // ✅ Validate required fields
      if (degreeController.text.trim().isEmpty ||
          universityController.text.trim().isEmpty ||
          startDateController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all required fields')),
        );
        return;
      }

      final request = QualificationRequest(
        degree:            degreeController.text.trim(),
        institutionName:   universityController.text.trim(),
        startDate:         startDateController.text.trim(),
        endDate:           isCurrentPosition ? '' : endDateController.text.trim(),
        isCurrentPosition: isCurrentPosition,
      );

      Navigator.pop(context);

      // ✅ Save then refresh list
      await context.read<QualificationProvider>().addQualification(request);
      await context.read<QualificationProvider>().fetchMyQualifications();
    },
  );
}

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
    builder: (_) => SizedBox(
      height: 300,
      child: Column(
        children: [
          // ── Done button ───────────────────────────────────────────
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
          // ── Picker ────────────────────────────────────────────────
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

