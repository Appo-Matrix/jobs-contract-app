import 'package:flutter/material.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/constants/app_text_style.dart';

class NoLanguageDialog extends StatelessWidget {
  final VoidCallback onAddLanguage;
  final VoidCallback onCancel;

  const NoLanguageDialog({
    super.key,
    required this.onAddLanguage,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dialog header indicator
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Warning icon
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange.shade700,
              size: 35,
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            "No Language Selected",
            style: AppTextStyle.dmSans(
              color: Colors.black,
              fontSize: 18.0,
              weight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),

          // Description
          Text(
            "Please add at least one language to continue. Language selection is required for proper functioning of the app.",
            style: AppTextStyle.dmSans(
              color: Colors.grey.shade700,
              fontSize: 14.0,
              weight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),

          // Add Language Button
          MainButton(
            btn_title: "Add Language",
            btn_radius: 8,
            btn_color: const Color(0xff7030F1),
            btn_boarder_color: const Color(0xff7030F1),
            title_color: Colors.white,
            image_value: false,
            onTap: onAddLanguage,
          ),
          const SizedBox(height: 12),

          // Cancel Button
          MainButton(
            btn_title: "Cancel",
            btn_radius: 8,
            btn_color: Colors.white,
            btn_boarder_color: Colors.grey.shade300,
            title_color: Colors.grey.shade700,
            image_value: false,
            onTap: onCancel,
          ),
        ],
      ),
    );
  }
}

// Usage example:
void showNoLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return NoLanguageDialog(
        onAddLanguage: () {
          Navigator.of(context).pop();
          // Navigate to language selection screen
          // Navigator.push(...);
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
      );
    },
  );
}