import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';
import 'package:globaluy_test_app/utils/flutter/DialogLoading.dart';

class Utils {
  static Future<String> getJson() {
    return rootBundle.loadString('lib/app/db.json');
  }

  static Map<String, String> getEnvParams() {
    var result = Map<String, String>();
    switch (dotenv.env["APP_ENV"]) {
      case 'local':
        result['API_URL'] = dotenv.env["API_DEV"] ?? '';
        break;
      case 'sandbox':
        result['API_URL'] = dotenv.env["API_SANDBOX"] ?? '';
        break;
      case 'production':
        result['API_URL'] = dotenv.env["API_PROD"] ?? '';
        break;
      default:
    }
    return result;
  }

  static Future<Map<String, dynamic>> httpBuilder(
      String method, String url, Map<String, dynamic>? values,
      {Map<String, String>? headers, bool? auth = true}) async {
    Map<String, dynamic> result = new Map<String, dynamic>();
    sharedPreferences sharedPrefs = sharedPreferences();
    var response;
    try {
      var dataUser =
          json.decode(await sharedPrefs.read(sharedPrefs.dataUser, '{}'));
      Map<String, String> _headers = headers ?? {};

      if (dataUser["token"] == null && auth == true) {
        result['estado'] = 'error';
        result['logout'] = true;
        return result;
      }
      if (auth == true) {
        _headers["Authorization"] = dataUser["token"];
      }
      switch (method) {
        case 'post':
          response =
              await http.post(Uri.parse(url), body: values, headers: _headers);
          break;
        case 'get':
          response = await http.get(Uri.parse(url), headers: _headers);
          break;
        default:
      }
      result = json.decode(response.body);
      if (result != '' && result['estado'] != null) {
        result['estado'] = result["estado"];
        if (result["mensaje"] != null) {
          result['mensaje'] = result["mensaje"];
        }
        return result;
      }
      throw Exception();
    } catch (e) {
      print('ERROR httpBuilder ${e}');
      if (response.statusCode == 401) {
        result['estado'] = 'error';
        result['logout'] = true;
      } else {
        result['estado'] = 'error';
        result['mensaje'] = 'Hubo un error al conectarse con el servidor';
      }
      return result;
    }
  }

  static String getMonthShortName(int monthNumber) {
    String month = "";
    List<String> months = [
      'ENE',
      'FEB',
      'MAR',
      'ABR',
      'MAY',
      'JUN',
      'JUL',
      'AGO',
      'SET',
      'OCT',
      'NOV',
      'DIC'
    ];
    month = months[monthNumber - 1];
    return month;
  }

  static DateTime setLocale(
      {String locale = 'es_UY', required DateTime datetime}) {
    DateTime result;
    result = datetime.toUtc().subtract(const Duration(hours: 3));

    return result;
  }
}
