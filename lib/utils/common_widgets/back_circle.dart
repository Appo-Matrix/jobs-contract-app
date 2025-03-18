import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';

class BackCircle extends StatelessWidget {
  const BackCircle({super.key, this.onTap, this.isDark});
final VoidCallback? onTap;
final bool?  isDark;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(

          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: JAppColors.darkGray400, width: 1),


        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Icon(
            size: 16,
            Icons.arrow_back_ios,
            color: isDark! ? JAppColors.lightGray100 :JAppColors.darkGray800,
          ),
        ),
      ),
    );
  }
}
