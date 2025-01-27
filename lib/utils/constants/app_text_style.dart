import 'package:flutter/material.dart';

class AppTextStyle {

  static roboto({
    required Color color,required fontSize, required FontWeight weight,  height= 1.0, shouldUnderline= false}){
    return TextStyle(height: height, color: color, fontWeight: weight, fontSize: fontSize, fontFamily: AppFontFamilies.roboto, decoration: shouldUnderline? TextDecoration.underline: TextDecoration.none, decorationColor: color);
  }

  static robotoCondenced({
    required Color color,required fontSize, required FontWeight weight, height}){
    return TextStyle(color: color, height: height, fontWeight: weight, fontSize: fontSize, fontFamily: AppFontFamilies.robotoCondenced,);
  }


  static plusJakartaSans({
    required Color color,required fontSize, required FontWeight weight, height}){
    return TextStyle(color: color, height: height, fontWeight: weight, fontSize: fontSize, fontFamily: AppFontFamilies.plusJakartaSans,);
  }

  static spaceGrotesk({
    required Color color,required fontSize, required FontWeight weight, height}){
    return TextStyle(color: color, height: height, fontWeight: weight, fontSize: fontSize, fontFamily: AppFontFamilies.spaceGrotesk,);
  }
}


class AppFontFamilies{
  static String roboto= 'roboto';
  static String robotoCondenced= 'robotoCondensed';
  static String plusJakartaSans= 'plusJakartaSans';
  static String spaceGrotesk= 'SpaceGrotesk';
}