import 'package:flutter/material.dart';

class AppTextStyle {

  static dmSans({
    required Color color,required fontSize, required FontWeight weight,  height= 1.0, shouldUnderline= false}){
    return TextStyle(height: height, color: color, fontWeight: weight, fontSize: fontSize, fontFamily: AppFontFamilies.dm_sans, decoration: shouldUnderline? TextDecoration.underline: TextDecoration.none, decorationColor: color);
  }

  static domaineArrow({
    required Color color,required fontSize, required FontWeight weight,  height= 1.0, shouldUnderline= false}){
    return TextStyle(height: height, color: color, fontWeight: weight, fontSize: fontSize, fontFamily: AppFontFamilies.dm_sans, decoration: shouldUnderline? TextDecoration.underline: TextDecoration.none, decorationColor: color);
  }

}


class AppFontFamilies {
  static String dm_sans = 'dm_sans';
  static String domaine_arrow = 'domaine_arrow';
}