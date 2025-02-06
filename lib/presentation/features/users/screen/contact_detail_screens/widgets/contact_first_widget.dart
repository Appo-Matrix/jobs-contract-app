import 'package:flutter/material.dart';

import '../../../../../../utils/common_widgets/main_button.dart';
import '../../../../../../utils/constants/colors.dart';

class ContactFirstWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const ContactFirstWidget({
    super.key, required this.title, required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        Spacer(),
        SizedBox(
          width: 120,
          height: 45,
          child: MainButton(
            btn_title: subTitle,
            btn_radius: 8,
            btn_color: JAppColors.primary,
            btn_boarder_color: Colors.transparent,
            title_color: Colors.white,
            image_value: false,
            text_size: 14,
          ),
        )
      ],
    );
  }
}