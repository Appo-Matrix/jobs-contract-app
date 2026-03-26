// utils/common_widgets/cupertino_date_picker.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCupertinoDatePicker(
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
            // ── Cancel / Done ─────────────────────────────────────────
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
            // ── Picker ────────────────────────────────────────────────
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