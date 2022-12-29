import 'dart:convert';

import 'package:globaluy_test_app/utils/dart/Utils.dart';

class RequestedProductService {
  Future<bool> sendOrder({
    required List<dynamic> products,
  }) async {
    final Map<String, dynamic> values = {
      'products': jsonEncode(products),
    };
    var envParams = Utils.getEnvParams();
    final response = await Utils.httpBuilder(
        'post', '${envParams["API_URL"]}send_order', values,
        auth: true);
    if (response["status"] == null) {
      return true;
    }
    return false;
  }
}
