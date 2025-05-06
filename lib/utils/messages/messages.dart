
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Messages{

  static toastMessage(String message){
    Fluttertoast.showToast(msg: message,
    );
  }

  static void flashBarErrorMessage(String message, BuildContext context) {
    Flushbar(
      message: message,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ).show(context);
  }
  static showSnakbar(String message ,BuildContext context){

    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  }

}