import 'package:get/get.dart';
import 'package:globaluy_test_app/app/controller/LoginController.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';

class NavigationController extends GetxController {
  final _navigation_index = 1.obs;
  set navigation_index(value) => this._navigation_index.value = value;
  get navigation_index => this._navigation_index.value;

  Future<bool> logout() async {
    if (await googleSignin.isSignedIn()) {
      googleSignin.disconnect();
    } else {
      sharedPreferences sharedPrefs = new sharedPreferences();
      sharedPrefs.clearSesion();
    }
    return true;
  }
}
