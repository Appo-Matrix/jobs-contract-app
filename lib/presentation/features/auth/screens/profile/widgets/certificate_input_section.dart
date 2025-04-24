import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/common_widgets/text_field_widget.dart';
import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';

class CertificateInputSection extends StatelessWidget {
  final bool isDark;

  const CertificateInputSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'certificatesAndLicenses',
          style: AppTextStyle.dmSans(
            color: isDark ? Colors.white : JAppColors.darkGray800,
            fontSize: 20.0,
            weight: FontWeight.w600,
          ),
        ).tr(),
        const SizedBox(height: 16),
        TextFieldWidget(
          subTitle: 'certificateOrLicenseName'.tr(),
          subtitleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
          titleColor: isDark ? JAppColors.lightGray300 : JAppColors.grayBlue800,
        ),
      ],
    );
  }
}
