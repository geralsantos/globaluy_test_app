import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globaluy_test_app/app/controller/RequestProductController.dart';
import 'package:globaluy_test_app/app/model/CompanyProductModel.dart';
import 'package:globaluy_test_app/app/model/ProductModel.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';
import 'package:globaluy_test_app/utils/flutter/DialogLoading.dart';
import 'package:globaluy_test_app/utils/flutter/SnackBarMessage.dart';

class RequestProductsIndex extends StatelessWidget {
  RequestProductsIndex({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScrollController _controller = new ScrollController();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primary,
        label: Text('Check my order'),
        onPressed: () {
          Navigator.pushNamed(context, '/products_requested');
        },
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Request products',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: AppTheme.title,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.darkText,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(top: 5, right: 8),
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 5, bottom: 5),
                    child: Row(children: [
                      Obx(
                        () => Text(
                          '${requestProductController.qty_product_requested.value}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.white,
                      )
                    ]),
                  )
                ],
              ),
              GetBuilder<RequestProductController>(
                  init: RequestProductController(),
                  id: 'products_requested',
                  builder: (_) {
                    List<Widget> items = [];
                    for (var element
                        in requestProductController.products_requested) {
                      items.add(Padding(
                        padding: const EdgeInsets.all(6),
                        child: ItemProduct(context, element),
                      ));
                    }
                    return requestProductController.loading.value
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 80),
                            child: Column(
                              children: items,
                            ),
                          );
                  })
            ],
          )),
    );
  }

  Widget ItemProduct(BuildContext context, ProductModel item) {
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
                          item.url,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              item.description,
                              style: AppTheme.subtitle,
                            ),
                            const Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text('${item.stock} qty'),
                                    Text(item.unit),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      Ink(
                                          decoration: BoxDecoration(
                                            color: AppTheme.primary,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              if (item.qty_product_requested ==
                                                  0) {
                                                return;
                                              }
                                              requestProductController
                                                  .removeQtyProductRequest(
                                                      product_id: item.id);
                                            },
                                            borderRadius:
                                                BorderRadius.circular(7),
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
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                            '${item.qty_product_requested}'),
                                      ),
                                      Ink(
                                          decoration: BoxDecoration(
                                            color: AppTheme.primary,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              if (item.qty_product_requested ==
                                                  item.stock) {
                                                return;
                                              }
                                              requestProductController
                                                  .addQtyProductRequest(
                                                      product_item: item);
                                            },
                                            borderRadius:
                                                BorderRadius.circular(7),
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
}
