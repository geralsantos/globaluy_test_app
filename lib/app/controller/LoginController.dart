import 'dart:convert';

import 'package:get/get.dart';
import 'package:globaluy_test_app/app/model/UserModel.dart';
import 'package:globaluy_test_app/app/services/LoginService.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

var googleSignin = GoogleSignIn();

class LoginController extends GetxController {
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  final _email = "".obs;
  final _password = "".obs;
  set email(value) => this._email.value = value;
  get email => this._email.value;

  set password(value) => this._password.value = value;
  get password => this._password.value;

  Future loginGoogle() async {
    return googleAccount.value = await googleSignin.signIn();
  }

  Future<bool> login() async {
    //_loading = true;
    bool response = await LoginService().signIn(email, password);
    if (response) {
      return true;
    }
    return false;
  }
}
