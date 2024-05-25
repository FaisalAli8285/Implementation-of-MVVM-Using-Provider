import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider_mvm/model/user_model.dart';
import 'package:provider_mvm/utils/routes/route_name.dart';
import 'package:provider_mvm/viewmodel/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() async {
    return UserViewModel().getUser();
  }

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      print(value.token.toString());
      if (value.token == "null" || value.token == "") {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
