import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvm/model/user_model.dart';
import 'package:provider_mvm/repository/auth_repository.dart';
import 'package:provider_mvm/utils/routes/route_name.dart';
import 'package:provider_mvm/utils/utils.dart';
import 'package:provider_mvm/viewmodel/user_view_model.dart';

class AuthViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading {
    return _loading;
  }

  bool _signUpLoading = false;
  bool get sigUpLoading {
    return _signUpLoading;
  }

  setLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final _myrepo = AuthRepository();
  Future<void> loginApiModel(dynamic data, BuildContext context) async {
    setLoading(true);
    _myrepo.loginApi(data).then((value) {
      setLoading(false);
      UserViewModel userViewModel =
          Provider.of<UserViewModel>(context, listen: false);
      userViewModel.saveUser(UserModel(token: value["token"].toString()));
      Utils.flushBarErrorMessage("Login Successfully", context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> signUpApiModel(dynamic data, BuildContext) async {
    setSignUpLoading(true);
    _myrepo.signUpApi(data).then((value) {
      if (kDebugMode) {
        setSignUpLoading(false);
        Utils.flushBarErrorMessage("Login Successfully", BuildContext);
        print(value.toString());
        Navigator.pushNamed(BuildContext, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), BuildContext);
        print(error.toString());
      }
    });
  }
}
