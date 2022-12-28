import 'dart:convert';

import 'package:get/get.dart';
import 'package:globaluy_test_app/app/model/ProductModel.dart';
import 'package:globaluy_test_app/app/services/RequestProductService.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';

final requestProductController = Get.put(RequestProductController());

class RequestProductController extends GetxController {
  final loading = true.obs;
  final RxInt qty_product_requested = 0.obs;
  Rx<List<ProductModel>> _products_requested = Rx<List<ProductModel>>([]);

  set products_requested(value) => this._products_requested.value = value;
  List<ProductModel> get products_requested => this._products_requested.value;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getProductsRequested();
  }

  /// It gets the products requested from the server and sets the loading value to true while it's
  /// loading and false when it's done loading
  /// Returns:
  ///   A list of ProductModel objects.
  Future getProductsRequested() async {
    sharedPreferences sharedPrefs = sharedPreferences();
    loading.value = true;
    update(['loading']);

    products_requested = await RequestProductService().getProductsRequested();
    List<dynamic> sp_products_requested = jsonDecode(
        await sharedPrefs.read(sharedPrefs.dataProductsRequested, '[]'));
    if (!sp_products_requested.isEmpty) {
      for (var i = 0; i < products_requested.length; i++) {
        ProductModel item = products_requested[i];
        int index_element = sp_products_requested
            .indexWhere((element) => element["product_id"] == item.id);
        if (index_element != -1) {
          int qty =
              int.parse(sp_products_requested[index_element]["qty"].toString());
          products_requested[i] =
              products_requested[i].copyWith(qty_product_requested: qty);
          qty_product_requested.value = sp_products_requested.length;
        }
      }
    }
    loading.value = false;
    update(['loading', 'products_requested']);
    return products_requested;
  }

  Future removeQtyProductRequest({product_id}) async {
    sharedPreferences sharedPrefs = sharedPreferences();
    List<dynamic> sp_products_requested = jsonDecode(
        await sharedPrefs.read(sharedPrefs.dataProductsRequested, '[]'));

    int index_element = sp_products_requested
        .indexWhere((element) => element["product_id"] == product_id);
    int new_qty = 1;
    if (index_element != -1) {
      new_qty =
          int.parse(sp_products_requested[index_element]["qty"].toString()) - 1;
      if (new_qty == 0) {
        sp_products_requested.removeAt(index_element);
      } else {
        sp_products_requested[index_element]["qty"] = new_qty;
      }
      sharedPrefs.save(
          sharedPrefs.dataProductsRequested, jsonEncode(sp_products_requested));
    }
    int index_ =
        products_requested.indexWhere((element) => element.id == product_id);
    products_requested[index_] =
        products_requested[index_].copyWith(qty_product_requested: new_qty);
    qty_product_requested.value = sp_products_requested.length;
    update(['products_requested']);
  }

  Future addQtyProductRequest({required ProductModel product_item}) async {
    sharedPreferences sharedPrefs = sharedPreferences();
    // sharedPrefs.remove(sharedPrefs.dataProductsRequested);
    List<dynamic> sp_products_requested = jsonDecode(
        await sharedPrefs.read(sharedPrefs.dataProductsRequested, '[]'));

    int index_element = sp_products_requested
        .indexWhere((element) => element["product_id"] == product_item.id);
    int new_qty = 1;
    if (index_element == -1) {
      Map<String, dynamic> product = {
        'product_id': product_item.id,
        'description': product_item.description,
        'unit': product_item.unit,
        'url': product_item.url,
        'qty': new_qty
      };
      sp_products_requested.add(product);
      sharedPrefs.save(
          sharedPrefs.dataProductsRequested, jsonEncode(sp_products_requested));
    } else {
      new_qty =
          int.parse(sp_products_requested[index_element]["qty"].toString()) + 1;

      sp_products_requested[index_element]["qty"] = new_qty;
      sharedPrefs.save(
          sharedPrefs.dataProductsRequested, jsonEncode(sp_products_requested));
    }
    int index_ = products_requested
        .indexWhere((element) => element.id == product_item.id);
    products_requested[index_] =
        products_requested[index_].copyWith(qty_product_requested: new_qty);
    qty_product_requested.value = sp_products_requested.length;
    update(['products_requested']);
  }

  Future removeProduct({product_id}) async {
    sharedPreferences sharedPrefs = sharedPreferences();
    List<dynamic> sp_products_requested = jsonDecode(
        await sharedPrefs.read(sharedPrefs.dataProductsRequested, '[]'));

    int index_element =
        products_requested.indexWhere((element) => element.id == product_id);
    products_requested[index_element] =
        products_requested[index_element].copyWith(qty_product_requested: 0);
    qty_product_requested.value = sp_products_requested.length;
    print('products_requested[index_element]');
    print(products_requested[index_element]);
    update(['products_requested']);
  }
  // Future<List<Map<String, dynamic>>> getProductsRequested() async {
  //   loading.value = true;
  //   products_requested = await RequestProductService().getProductsRequested();
  //   loading.value = false;
  //   return products_requested;
  // }
}
