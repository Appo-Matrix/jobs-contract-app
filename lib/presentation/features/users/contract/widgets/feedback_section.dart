// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:job_contracts/utils/constants/colors.dart';
// import 'package:job_contracts/utils/constants/app_text_style.dart';
// import 'package:job_contracts/utils/constants/sizes.dart';
// import 'package:job_contracts/utils/device/device_utility.dart';
//
// class FeedbackSection extends StatelessWidget {
//   final String title;
//   final List<String> options;
//
//   const FeedbackSection({
//     super.key,
//     required this.title,
//     required this.options,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = JDeviceUtils.isDarkMode(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: AppTextStyle.dmSans(
//             color: isDark ? JAppColors.primary : JAppColors.primary,
//             fontSize: JSizes.fontSizeSm,
//             weight: FontWeight.w500,
//           ),
//         ).tr(),
//         SizedBox(height: 10),
//         Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: options.map((option) {
//             return Chip(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 side: BorderSide(color: Colors.transparent),
//               ),
//               label: Text(
//                 option,
//                 style: AppTextStyle.dmSans(
//                   color: isDark
//                       ? JAppColors.darkGray100
//                       : JAppColors.lightGray1000,
//                   fontSize: 12.0,
//                   weight: FontWeight.w400,
//                 ),
//               ),
//               backgroundColor:isDark ?JAppColors.backGroundDarkCard : JAppColors.darkGray800,
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/constants/sizes.dart';
import 'package:job_contracts/utils/constants/app_text_style.dart';
import 'package:job_contracts/utils/device/device_utility.dart';

class FeedbackSection extends StatefulWidget {
  final String title;
  final List<String> options;
  final Function(String?)? onSelectionChanged;

  const FeedbackSection({
    Key? key,
    required this.title,
    required this.options,
    this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<FeedbackSection> createState() => _FeedbackSectionState();
}

class _FeedbackSectionState extends State<FeedbackSection> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final isDark = JDeviceUtils.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTextStyle.dmSans(
            color: isDark ? JAppColors.darkGray100 : JAppColors.darkGray700,
            fontSize: JSizes.fontSizeMd,
            weight: FontWeight.w600,
          ),
        ).tr(),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.options.map((option) {
            final isSelected = _selectedOption == option;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedOption = isSelected ? null : option;
                });

                // Notify parent about the selection change
                if (widget.onSelectionChanged != null) {
                  widget.onSelectionChanged!(_selectedOption);
                }

                // Debug log
                print('Selected ${widget.title}: $_selectedOption');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark ? JAppColors.main : JAppColors.main)
                      : (isDark ? JAppColors.darkGray700 : JAppColors.lightGray200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  option,
                  style: AppTextStyle.dmSans(
                    color: isSelected
                        ? Colors.white
                        : (isDark ? JAppColors.darkGray300 : JAppColors.darkGray600),
                    fontSize: 14.0,
                    weight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}