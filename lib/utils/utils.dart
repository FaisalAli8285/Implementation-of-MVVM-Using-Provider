import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider_mvm/res/components/custom_color.dart';

class Utils {
  static void fieldFOcusNode(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(20),
          reverseAnimationCurve: Curves.easeInOut,
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 10,
          borderRadius: BorderRadius.circular(20),
          icon: Icon(
            Icons.error,
            size: 20,
            color: Colors.white,
          ),
          message: message,
          backgroundColor: Colors.red,
          messageColor: AppColor.whiteColor,
          duration: Duration(seconds: 3),
        )..show(context));
  }

  static showSnackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}
