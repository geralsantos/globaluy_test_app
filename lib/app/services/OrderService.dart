import 'dart:convert';

import 'package:globaluy_test_app/app/model/CompanyProductModel.dart';
import 'package:globaluy_test_app/app/model/OrderModel.dart';
import 'package:globaluy_test_app/app/model/UserModel.dart';
import 'package:globaluy_test_app/utils/dart/Utils.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';

class OrderService {
  /// It makes a GET request to the API, and if the response is successful, it returns a list of
  /// OrderModel objects
  ///
  /// Returns:
  ///   A list of OrderModel objects.
  Future<List<OrderModel>> getOrders() async {
    final Map<String, dynamic> values = {};
    var envParams = Utils.getEnvParams();
    final response = await Utils.httpBuilder(
        'get', '${envParams["API_URL"]}orders', values,
        auth: true);
    if (response["status"] == null) {
      List<OrderModel> list = [];
      for (var item in response["response"]) {
        list.add(OrderModel.fromJson(item));
      }
      return list;
    }
    return [];
  }

  /// It takes an order_id, makes a POST request to the server, and returns true if the server returns a
  /// status of null
  ///
  /// Args:
  ///   order_id (int): The order id of the order you want to process.
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> processOrder({required int order_id}) async {
    final Map<String, dynamic> values = {
      'order_id': order_id.toString(),
    };
    var envParams = Utils.getEnvParams();
    final response = await Utils.httpBuilder(
        'post', '${envParams["API_URL"]}process_order', values,
        auth: true);
    if (response["status"] == null) {
      return true;
    }
    return false;
  }
}
