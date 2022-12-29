import 'dart:convert';

import 'package:globaluy_test_app/utils/dart/Utils.dart';

class RequestedProductService {
  /// It takes a list of products, converts it to a json string, and sends it to the server
  ///
  /// Args:
  ///   products (List<dynamic>): List of products to be sent to the server.
  ///
  /// Returns:
  ///   A Future<bool>
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
