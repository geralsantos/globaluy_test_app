import 'dart:convert';

import 'package:get/get.dart';
import 'package:globaluy_test_app/app/model/UserModel.dart';
import 'package:globaluy_test_app/app/services/LoginService.dart';
import 'package:globaluy_test_app/utils/dart/Utils.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

var googleSignin = GoogleSignIn();

class LoginController extends GetxController {
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  final _password_obscure_text = true.obs;
  final _email = "".obs;
  final _password = "".obs;
  final _full_name = "".obs;
  final _rol_id = 0.obs;
  set email(value) => this._email.value = value;
  get email => this._email.value;

  set password(value) => this._password.value = value;
  get password => this._password.value;

  set full_name(value) => this._full_name.value = value;
  get full_name => this._full_name.value;

  set rol_id(value) => this._rol_id.value = value;
  get rol_id => this._rol_id.value;
  set password_obscure_text(value) => this._password_obscure_text.value = value;
  get password_obscure_text => this._password_obscure_text.value;
  Future<bool> loginGoogle() async {
    googleAccount.value = await googleSignin.signIn();
    full_name = googleAccount.value?.displayName;
    rol_id = 1;
    email = googleAccount.value?.email;
    password = googleAccount.value?.id;

    await signUp();
    await login();

    return googleAccount.value?.displayName != null;
  }

  Future<bool> login() async {
    //_loading = true;

    bool response = await LoginService().signIn(email, password);

    if (response) {
      return true;
    }
    return false;
  }

  Future<bool> signUp() async {
    //_loading = true;
    bool response =
        await LoginService().signUp(email, password, full_name, rol_id);
    if (response) {
      return true;
    }
    return false;
  }
}
