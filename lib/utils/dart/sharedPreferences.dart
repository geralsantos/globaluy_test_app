import 'dart:convert';

import 'package:globaluy_test_app/app/exceptions/AuthException.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sharedPreferences {
  var pref;
  String dataUser = 'dataUser';
  String dataProductsRequested = 'dataProductsRequested';

  Future<void> open() async {
    pref = await SharedPreferences.getInstance();
  }

  void save(String key, String value) async {
    if (pref == null) {
      await open();
    }
    pref.setString(key, value);
  }

  Future<String> read(String key, dynamic def) async {
    if (pref == null) {
      await open();
    }

    return pref.getString(key) ?? def;
  }

  Future remove(String key) async {
    if (pref == null) {
      await open();
    }
    pref.remove(key);
  }

  Future clearSesion() async {
    if (pref == null) {
      await open();
    }
    await pref.clear();
  }

  Future checkUser() async {
    if (pref == null) {
      await open();
    }
    var user = json.decode(await read(dataUser, null));
    if (user == null) {
      throw AuthException('');
    }
    return user;
  }
}
