import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_contracts/utils/constants/colors.dart';

class BackCircle extends StatelessWidget {
  const BackCircle({super.key, this.onTap, this.isDark});
final VoidCallback? onTap;
final bool?  isDark;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(

            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: JAppColors.darkGray400, width: 1),


          ),
          child: Icon(
            size: 22,
            weight: 700,
            Iconsax.arrow_left_2,  // Using Iconsax's back arrow icon
            color: isDark! ? JAppColors.lightGray100 :JAppColors.darkGray800,
          ),
        ),
      ),
    );
  }
}
