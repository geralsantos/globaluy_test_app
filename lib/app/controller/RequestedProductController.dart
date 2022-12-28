import 'dart:convert';

import 'package:get/get.dart';
import 'package:globaluy_test_app/app/controller/RequestProductController.dart';
import 'package:globaluy_test_app/app/model/ProductModel.dart';
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

    // if (!sp_products_requested.isEmpty) {
    //   for (var i = 0; i < sp_products_requested.length; i++) {
    //     products_requested.add(sp_products_requested[i]);
    //   }
    // }
    print('sp_products_requested.isEmpty');
    print(products_requested);
    loading.value = false;
    update(['loading', 'products_requested']);
  }

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
  // Future<List<Map<String, dynamic>>> getProductsRequested() async {
  //   loading.value = true;
  //   products_requested = await RequestProductService().getProductsRequested();
  //   loading.value = false;
  //   return products_requested;
  // }
}
