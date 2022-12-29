import 'dart:convert';

import 'package:get/get.dart';
import 'package:globaluy_test_app/app/model/CompanyProductModel.dart';
import 'package:globaluy_test_app/app/model/OrderModel.dart';
import 'package:globaluy_test_app/app/services/OrderService.dart';
import 'package:globaluy_test_app/app/services/ProductsAvailableService.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';

final orderController = Get.put(OrderController());

class OrderController extends GetxController {
  final loading = true.obs;
  Rx<List<OrderModel>> _order_items = Rx<List<OrderModel>>([]);

  set order_items(value) => this._order_items.value = value;
  List<OrderModel> get order_items => this._order_items.value;

  /// `getOrders()` is an async function that sets the loading value to true, then calls the
  /// `OrderService().getOrders()` function, which returns a Future. Once the Future is resolved, the
  /// loading value is set to false, and the `update()` function is called
  Future getOrders() async {
    loading.value = true;
    order_items = await OrderService().getOrders();
    loading.value = false;

    update(['order_items']);
  }

  /// `processOrder` is an async function that returns a Future<bool> and calls the `processOrder`
  /// function in the `OrderService` class
  ///
  /// Args:
  ///   order (OrderModel): The order model that is being processed.
  ///
  /// Returns:
  ///   A Future<bool>
  Future<bool> processOrder(OrderModel order) async {
    bool updated = await OrderService().processOrder(order_id: order.id!);
    getOrders();
    return updated;
  }
}
