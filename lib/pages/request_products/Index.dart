import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:globaluy_test_app/app/controller/ProductAvailableController.dart';
import 'package:globaluy_test_app/app/model/CompanyProductModel.dart';
import 'package:globaluy_test_app/app/model/ProductModel.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';
import 'package:globaluy_test_app/utils/flutter/ButtonField.dart';
import 'package:globaluy_test_app/utils/flutter/DialogLoading.dart';
import 'package:globaluy_test_app/utils/flutter/SnackBarMessage.dart';

class RequestProductsIndex extends StatelessWidget {
  RequestProductsIndex({super.key});
  final controller = Get.put(ProductAvailableController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScrollController _controller = new ScrollController();

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                const Flexible(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Request products',
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: AppTheme.title,
                      )),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.darkText,
                  ),
                  child: Row(children: const [
                    Text('100'),
                    SizedBox(width: 5),
                    Icon(Icons.shopping_cart_rounded)
                  ]),
                )
              ],
            ),
            Obx(() {
              List<Widget> items = [];
              for (var element in controller.products_available) {
                items.add(Padding(
                  padding: const EdgeInsets.all(6),
                  child: ItemProduct(context, element),
                ));
              }
              return controller.loading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: size.height + 50,
                      child: Column(
                        children: items,
                      ),
                    );
            })
          ],
        ));
  }

  Widget ItemProduct(BuildContext context, CompanyProductModel item) {
    final size = MediaQuery.of(context).size;
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () async {},
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  width: size.width - 170,
                  height: 100,
                  padding: const EdgeInsets.only(right: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Image.network(
                          item.product.url,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              item.product.description,
                              style: AppTheme.subtitle,
                            ),
                            const Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text('${item.quantity} qty'),
                                    Text(item.product.unit),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12), // <-- Radius
                                        ),
                                        primary: AppTheme.primary),
                                    onPressed: () {
                                      controller.qty_product_removed.value = 0;
                                      discountProduct(context, item);
                                    },
                                    child: const Text(
                                      'Remove',
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
              ],
            ),
          )),
    );
  }

  void discountProduct(BuildContext context, CompanyProductModel item) {
    showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 170,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        child: Text(
                      item.product.description,
                      style: AppTheme.title,
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Ink(
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (controller.qty_product_removed.value == 0) {
                                  return;
                                }
                                controller.qty_product_removed.value--;
                              },
                              borderRadius: BorderRadius.circular(7),
                              child: const SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.remove_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Obx(() =>
                              Text('${controller.qty_product_removed.value}')),
                        ),
                        Ink(
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (controller.qty_product_removed.value ==
                                    item.quantity) {
                                  return;
                                }
                                controller.qty_product_removed.value++;
                              },
                              borderRadius: BorderRadius.circular(7),
                              child: const SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.add_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                            primary: AppTheme.primary),
                        onPressed: () {
                          if (controller.qty_product_removed == 0) {
                            return;
                          }
                          DialogLoading('Discounting product', context);
                          controller.updateProductAvailable(item).then((value) {
                            Get.back();

                            if (value) {
                              SnackBarMessage(context,
                                  isSuccess: true,
                                  message: 'Product discounted');
                            } else {
                              SnackBarMessage(context,
                                  message:
                                      'The product could not be discounted');
                            }
                            Future.delayed(const Duration(milliseconds: 300))
                                .then((value) {
                              Get.back();
                            });
                          });
                        },
                        child: Obx(() => Text(
                              'Remove ${controller.qty_product_removed.value} units',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.white),
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
