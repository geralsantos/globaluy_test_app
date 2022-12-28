import 'dart:convert';

import 'package:globaluy_test_app/app/model/ProductModel.dart';
import 'package:globaluy_test_app/utils/dart/Utils.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';

class RequestProductService {
  Future<List<ProductModel>> getProductsRequested() async {
    final Map<String, dynamic> values = {};
    var envParams = Utils.getEnvParams();
    final response = await Utils.httpBuilder(
        'get', '${envParams["API_URL"]}products', values,
        auth: true);
    if (response["status"] == null) {
      List<ProductModel> list_product = [];
      for (var item in response["response"]) {
        list_product.add(ProductModel.fromJson(item));
      }
      print('response list_product');
      print(list_product);
      return list_product;
    }
    return [];
  }
}
