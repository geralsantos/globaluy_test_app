import 'dart:convert';

import 'package:globaluy_test_app/app/model/CompanyProductModel.dart';
import 'package:globaluy_test_app/app/model/UserModel.dart';
import 'package:globaluy_test_app/utils/dart/Utils.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';

class ProductsAvailableService {
  Future<List<CompanyProductModel>> getProductsAvailable() async {
    final Map<String, dynamic> values = {};
    var envParams = Utils.getEnvParams();
    final response = await Utils.httpBuilder(
        'get', '${envParams["API_URL"]}products_availables', values,
        auth: true);
    if (response["status"] == null) {
      List<CompanyProductModel> list_company_product = [];
      for (var item in response["response"]) {
        list_company_product.add(CompanyProductModel.fromJson(item));
      }
      print('response list_company_product');
      print(list_company_product);
      return list_company_product;
    }
    return [];
  }

  Future<bool> updateProductAvailable(
      {required int company_id,
      required int product_id,
      required int quantity}) async {
    final Map<String, dynamic> values = {
      'company_id': company_id.toString(),
      'product_id': product_id.toString(),
      'quantity': quantity.toString()
    };
    var envParams = Utils.getEnvParams();
    final response = await Utils.httpBuilder(
        'put', '${envParams["API_URL"]}update_product_available', values,
        auth: true);
    if (response["status"] == null) {
      return true;
    }
    return false;
  }
}
