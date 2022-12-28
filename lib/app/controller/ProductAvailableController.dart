import 'dart:convert';

import 'package:get/get.dart';
import 'package:globaluy_test_app/app/model/CompanyProductModel.dart';
import 'package:globaluy_test_app/app/services/ProductsAvailableService.dart';

class ProductAvailableController extends GetxController {
  final loading = true.obs;
  final RxInt qty_product_removed = 0.obs;
  Rx<List<CompanyProductModel>> _products_available =
      Rx<List<CompanyProductModel>>([]);

  set products_available(value) => this._products_available.value = value;
  List<CompanyProductModel> get products_available =>
      this._products_available.value;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getProductsAvailable();
  }

  Future<List<CompanyProductModel>> getProductsAvailable() async {
    loading.value = true;
    products_available =
        await ProductsAvailableService().getProductsAvailable();
    loading.value = false;

    if (products_available.isEmpty) {
      return [];
    }
    return products_available;
  }

  Future<bool> updateProductAvailable(CompanyProductModel item) async {
    //loading.value = true;
    bool updated = await ProductsAvailableService().updateProductAvailable(
        company_id: item.company_id,
        product_id: item.product_id,
        quantity: qty_product_removed.value.toInt());
    getProductsAvailable();
    //loading.value = false;

    return updated;
  }
}
