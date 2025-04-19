// import 'package:flutter/material.dart';
// import '../constants/app_text_style.dart';
//
// class MainButton extends StatelessWidget {
//   final String btn_title;
//   final String? btn_image;
//   final double btn_radius;
//   final Color btn_color;
//   final Color title_color;
//   final Color? btn_boarder_color;
//   final double? text_size;
//   final FontWeight? text_fontweight;
//   final bool image_value;
//   final VoidCallback? onTap;
//
//   const MainButton({
//     super.key,
//     required this.btn_title,
//     required this.btn_radius,
//     required this.btn_color,
//      this.btn_boarder_color = Colors.transparent,
//     required this.title_color,
//     this.text_size = 16,
//     this.text_fontweight = FontWeight.w600,
//     this.btn_image = '',
//     required this.image_value,
//     this.onTap,
//
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child:
//       Container(
//         width: MediaQuery.of(context).size.width,
//         height: 50,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(btn_radius)),
//             color: btn_color, //Color(0xff7030F1),
//             border: Border.all(color: btn_boarder_color!)),
//         child: Padding(
//           padding:
//               const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 10),
//           child: Center(
//               child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (image_value == true)
//                 Row(
//                   children: [
//                     Image.asset(
//                       btn_image!,
//                       width: 24,
//                       height: 24,
//                     ),
//                     SizedBox(width: 10),
//                   ],
//                 ),
//               Text(
//                 btn_title,
//                 style: AppTextStyle.dmSans(
//                     color: title_color,
//                     fontSize: 16.0,
//                     weight: text_fontweight!),
//               ),
//             ],
//           )),
//         ),
//       ),
//     );
//     ;
//   }
// }
import 'package:flutter/material.dart';
import '../constants/app_text_style.dart';
import '../constants/colors.dart';

class MainButton extends StatelessWidget {
  final String btn_title;
  final String? btn_image;
  final double btn_radius;
  final Color? btn_color;
  final Color title_color;
  final Color btn_boarder_color;
  final double? text_size;
  final FontWeight? text_fontweight;
  final bool image_value;
  final VoidCallback? onTap;
  final bool? isDark;

  const MainButton({
    super.key,
    required this.btn_title,
    required this.btn_radius,
    this.btn_color,
    required this.btn_boarder_color,
    required this.title_color,
    this.text_size = 16,
    this.text_fontweight = FontWeight.w600,
    this.btn_image = '',
    required this.image_value,
    this.onTap,
    this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(btn_radius),
          color: btn_color ?? (isDark == true
              ? JAppColors.backGroundDark
              : JAppColors.primary),
          border: Border.all(color: btn_boarder_color),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (image_value)
                  Row(
                    children: [
                      Image.asset(
                        btn_image!,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                Text(
                  btn_title,
                  style: AppTextStyle.dmSans(
                    color: title_color,
                    fontSize: text_size!,
                    weight: text_fontweight!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
