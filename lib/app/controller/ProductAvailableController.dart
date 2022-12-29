import 'dart:convert';

import 'package:get/get.dart';
import 'package:globaluy_test_app/app/model/CompanyProductModel.dart';
import 'package:globaluy_test_app/app/services/ProductsAvailableService.dart';

final productAvailableController = Get.put(ProductAvailableController());

class ProductAvailableController extends GetxController {
  final loading = true.obs;
  final RxInt qty_product_removed = 0.obs;
  Rx<List<CompanyProductModel>> _products_available =
      Rx<List<CompanyProductModel>>([]);

  set products_available(value) => this._products_available.value = value;
  List<CompanyProductModel> get products_available =>
      this._products_available.value;

  /// It gets the products available from the database and sets the loading value to false
  Future getProductsAvailable() async {
    loading.value = true;
    update(['loading']);
    products_available =
        await ProductsAvailableService().getProductsAvailable();
    loading.value = false;
    update(['products_available']);
  }

  /// It updates the quantity of a product in the database
  ///
  /// Args:
  ///   item (CompanyProductModel): is the product that is being removed from the list
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> updateProductAvailable(CompanyProductModel item) async {
    bool updated = await ProductsAvailableService().updateProductAvailable(
        company_id: item.company_id,
        product_id: item.product_id,
        quantity: qty_product_removed.value.toInt());
    getProductsAvailable();
    return updated;
  }
}
