import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';

class BackCircle extends StatelessWidget {
  const BackCircle({super.key, this.onTap});
final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(80),
          border: Border.all(color: JAppColors.darkGray400, width: 1),


        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            size: 20,
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
