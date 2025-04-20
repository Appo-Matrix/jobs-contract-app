import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_text_style.dart';
import '../../../../../../utils/constants/colors.dart';

class FileAttachment extends StatelessWidget {
  final bool isDark;

  const FileAttachment({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? JAppColors.backGroundDarkCard.withValues(alpha: 0.1): Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? JAppColors.darkGray500 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'You Send a File.',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                  fontSize: 14.0,
                  weight: FontWeight.w500,
                ),
              ),
              Text(
                '12:00 Pm',
                style: AppTextStyle.dmSans(
                  color: isDark ? JAppColors.darkGray400 : Colors.black54,
                  fontSize: 14.0,
                  weight: FontWeight.w400,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: JAppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'PNG',
                  style: AppTextStyle.dmSans(
                    color: Colors.white,
                    fontSize: 12.0,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Design.png',
                      style: AppTextStyle.dmSans(
                        color: isDark ? JAppColors.darkGray100 : JAppColors.lightGray900,
                        fontSize: 14.0,
                        weight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '200 KB',
                      style: AppTextStyle.dmSans(
                        color: isDark ? JAppColors.darkGray400 : Colors.black54,
                        fontSize: 12.0,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.download,
                  color: isDark ? JAppColors.darkGray100 : Colors.black,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
