import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:globaluy_test_app/app/exceptions/AuthException.dart';
import 'package:http/http.dart' as http;
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';
import 'package:globaluy_test_app/utils/flutter/DialogLoading.dart';

class Utils {
  static Future<String> getJson() {
    return rootBundle.loadString('lib/app/db.json');
  }

  /// It takes the value of the `APP_ENV` variable from the `.env` file and uses it to determine which
  /// API URL to use
  ///
  /// Returns:
  ///   A Map<String, String>
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

  /// It's a function that makes a request to the server and returns a map with the response
  ///
  /// Args:
  ///   method (String): The HTTP method to use.
  ///   url (String): The url of the API
  ///   values (Map<String, dynamic>): The data to be sent to the server.
  ///   headers (Map<String, String>): {'Content-Type': 'application/json'}
  ///   auth (bool): If the request requires authentication or not. Defaults to true
  ///
  /// Returns:
  ///   A Future<Map<String, dynamic>>
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
        result['status'] = 'error';
        result['logout'] = true;
        return result;
      }
      if (auth == true) {
        _headers["Authorization"] = 'Bearer ${dataUser["token"]}';
      }

      switch (method) {
        case 'post':
          response =
              await http.post(Uri.parse(url), body: values, headers: _headers);
          break;
        case 'put':
          response =
              await http.put(Uri.parse(url), body: values, headers: _headers);
          break;
        case 'get':
          response = await http.get(Uri.parse(url), headers: _headers);
          break;
        default:
      }

      result = json.decode(response.body);

      if (result != '' && result['response'] != null) {
        if (result["error"] != null) {
          result['error'] = result["error"];
        }
        return result;
      }
      throw Exception();
    } catch (e) {
      if (response.statusCode == 401) {
        result['status'] = 'error';
        result['logout'] = true;
      } else {
        result['status'] = 'error';
        result['error'] = 'Hubo un error al conectarse con el servidor';
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

  static String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}
