// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
//
// import '../constants/colors.dart';
//
// class FancyCircularLoader extends StatelessWidget {
//   const FancyCircularLoader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SimpleCircularProgressBar(
//       progressColors: const [
//         JAppColors.primary,
//         JAppColors.chartreuse200,
//         JAppColors.success300,
//       ],
//       backColor: Colors.transparent,
//       mergeMode: true,
//       animationDuration: 2,
//       backStrokeWidth: 3, // Decreased the stroke width
//       size: 50, // Reduced the size
//       onGetText: (double value) {
//         return Text(
//           '${value.toInt()}%',
//           style: const TextStyle(
//             fontSize: 14,
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:job_contracts/utils/constants/colors.dart';

class FancyCircularLoader extends StatelessWidget {
  const FancyCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,  // Control the size of the circular progress indicator
      height: 80,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(JAppColors.primary),  // Customize the color of the progress
        strokeWidth: 6,  // Set the stroke width for the progress circle
      ),
    );
  }
}
