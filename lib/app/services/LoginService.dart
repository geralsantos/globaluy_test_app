import 'dart:convert';

import 'package:globaluy_test_app/app/model/UserModel.dart';
import 'package:globaluy_test_app/utils/dart/Utils.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';

class LoginService {
  Future<bool> signIn(String email, String password) async {
    sharedPreferences sharedPrefs = new sharedPreferences();

    final Map<String, dynamic> values = {'email': email, 'password': password};

    var envParams = Utils.getEnvParams();
    final response = await Utils.httpBuilder(
        'post', '${envParams["API_URL"]}auth/login', values,
        auth: false);
    if (response["status"] == null) {
      UserModel user = UserModel.fromJson(response["response"]["user"]);
      sharedPrefs.save(
          sharedPrefs.dataUser,
          jsonEncode(
              {...user.toJson(), "token": response["response"]["token"]}));
      return true;
    }
    return false;
  }
}
