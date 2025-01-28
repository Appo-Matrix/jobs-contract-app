import 'package:flutter/material.dart';

class AppWidget{
  static TextStyle boldTextFieldStyle(){
    return  const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle HeadlineTextFieldStyle(){
    return  const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }
  static TextStyle LightTextFieldStyle(){
    return  const TextStyle(
        color: Colors.black38,
        fontSize: 10,

        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }

  static TextStyle semiBoldTextFieldStyle(){
    return  const TextStyle(
        color: Color(0xff1E1E1E),
        fontSize: 30,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins');
  }

  static TextStyle blueTextFieldStyle(){
    return  const TextStyle(
      decoration: TextDecoration.underline,
        color: Colors.black87,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        fontFamily: 'Poppins');
  }
}