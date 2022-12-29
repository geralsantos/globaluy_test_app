import 'dart:convert';

import 'package:globaluy_test_app/app/model/CompanyProductModel.dart';
import 'package:globaluy_test_app/app/model/UserModel.dart';
import 'package:globaluy_test_app/utils/dart/Utils.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';

class ProductsAvailableService {
  /// It makes a request to the server, and if the response is successful, it returns a list of
  /// CompanyProductModel objects
  ///
  /// Returns:
  ///   A list of CompanyProductModel objects.
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

      return list_company_product;
    }
    return [];
  }

  /// It takes in a company_id, product_id, and quantity, and updates the quantity of the product in the
  /// database
  ///
  /// Args:
  ///   company_id (int): The company id of the company that owns the product
  ///   product_id (int): The id of the product you want to update
  ///   quantity (int): The amount of the product that is available.
  ///
  /// Returns:
  ///   A Future<bool>
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
