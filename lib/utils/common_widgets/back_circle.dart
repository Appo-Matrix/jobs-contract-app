import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';

class BackCircle extends StatelessWidget {
  const BackCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: JAppColors.darkGray400, width: 1),


      ),
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    );
  }
}
