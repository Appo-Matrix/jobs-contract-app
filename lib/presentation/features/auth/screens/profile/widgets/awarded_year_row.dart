import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_strings.dart';

class AwardedYearRow extends StatelessWidget {
  final bool isDark;
  final String? selectedYear;
  final Color textColor;
  final Function(String?) onYearChange;
  final List<String> years;

  const AwardedYearRow({
    super.key,
    required this.isDark,
    required this.selectedYear,
    required this.textColor,
    required this.onYearChange,
    required this.years,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldWidget(
            subTitle: 'awardedBy'.tr(),
            subtitleColor: isDark ? JAppColors.lightGray100 : JAppColors.grayBlue800,
            titleColor: isDark ? Colors.white : JAppColors.grayBlue800,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'year'.tr(),
                style: AppTextStyle.dmSans(
                  color: textColor,
                  fontSize: 16.0,
                  weight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(

                height: 48,
                child: DropdownButtonFormField<String>(
                  value: selectedYear,
                  items: years.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: onYearChange,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: isDark ? JAppColors.backGroundDarkCard : Colors.transparent,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(width: 1.5, color: JAppColors.lightGray300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: JAppColors.light),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
