import 'dart:convert';

import 'package:get/get.dart';
import 'package:globaluy_test_app/app/controller/RequestProductController.dart';
import 'package:globaluy_test_app/app/model/ProductModel.dart';
import 'package:globaluy_test_app/app/services/RequestedProductService.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';

class RequestedProductController extends GetxController {
  final loading = true.obs;
  Rx<List<dynamic>> _products_requested = Rx<List<dynamic>>([]);

  set products_requested(value) => this._products_requested.value = value;
  List<dynamic> get products_requested => this._products_requested.value;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onReady
    super.onInit();
    //getProductsRequested();
  }

  /// It gets the products requested from the server and sets the loading value to true while it's
  /// loading and false when it's done loading
  /// Returns:
  ///   A list of ProductModel objects.
  Future getProductsRequested() async {
    sharedPreferences sharedPrefs = sharedPreferences();
    loading.value = true;
    update(['loading']);

    products_requested = jsonDecode(
        await sharedPrefs.read(sharedPrefs.dataProductsRequested, '[]'));
    loading.value = false;
    update(['loading', 'products_requested']);
  }

  /// It removes a product from the list of products requested
  ///
  /// Args:
  ///   product_id: The id of the product to be removed
  Future removeProduct({product_id}) async {
    sharedPreferences sharedPrefs = sharedPreferences();
    List<dynamic> sp_products_requested = jsonDecode(
        await sharedPrefs.read(sharedPrefs.dataProductsRequested, '[]'));

    int index_element = sp_products_requested
        .indexWhere((element) => element["product_id"] == product_id);
    sp_products_requested.removeAt(index_element);
    sharedPrefs.save(
        sharedPrefs.dataProductsRequested, jsonEncode(sp_products_requested));
    products_requested = sp_products_requested;
    requestProductController.removeProduct(product_id: product_id);

    update(['products_requested']);
  }

  /// It gets a list of products from shared preferences, sends them to the server, and if the server
  /// responds with a success, it removes the list from shared preferences
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> sendOrder() async {
    sharedPreferences sharedPrefs = sharedPreferences();
    List<dynamic> sp_products_requested = jsonDecode(
        await sharedPrefs.read(sharedPrefs.dataProductsRequested, '[]'));
    bool updated = await RequestedProductService().sendOrder(
      products: sp_products_requested,
    );
    if (updated) {
      await sharedPrefs.remove(sharedPrefs.dataProductsRequested);
      getProductsRequested();
      requestProductController.getProductsRequested();
    }
    return updated;
  }
}
