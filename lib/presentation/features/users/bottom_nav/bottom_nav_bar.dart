
import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';
import 'package:job_contracts/utils/helpers/helper_functions.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

    @override
  Widget build(BuildContext context) {
  final dark=  JHelperFunctions.isDarkMode(context);
    return Scaffold(

      backgroundColor: dark?JAppColors.lightGray100: JAppColors.darkGray800,

    );
  }
}
