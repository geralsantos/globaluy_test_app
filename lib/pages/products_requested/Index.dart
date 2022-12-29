import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globaluy_test_app/app/controller/RequestedProductController.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';
import 'package:globaluy_test_app/utils/flutter/DialogLoading.dart';
import 'package:globaluy_test_app/utils/flutter/RecordNotFound.dart';
import 'package:globaluy_test_app/utils/flutter/SnackBarMessage.dart';

class ProductsRequestedIndex extends StatefulWidget {
  const ProductsRequestedIndex({super.key});

  @override
  State<ProductsRequestedIndex> createState() => _ProductsRequestedIndexState();
}

class _ProductsRequestedIndexState extends State<ProductsRequestedIndex> {
  final controller = Get.put(RequestedProductController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getProductsRequested();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(() {
          if (!controller.products_requested.isEmpty) {
            return FloatingActionButton.extended(
              backgroundColor: AppTheme.primary,
              label: Text('Send my order'),
              onPressed: () {
                ConfirmDialog('¿ Send the order ?', () {
                  DialogLoading('Processing order', context);
                  controller.sendOrder().then((value) {
                    Get.back();
                    if (value) {
                      SnackBarMessage(context,
                          isSuccess: true,
                          message: 'Order processed successfully');
                    } else {
                      SnackBarMessage(context,
                          message: 'The order could not be processed');
                    }
                    Future.delayed(const Duration(milliseconds: 300))
                        .then((value) {
                      Get.back();
                    });
                  });
                }, null, context);
              },
            );
          }
          return SizedBox();
        }),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(15),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Products requested',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: AppTheme.title,
                                  )),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () async {
                                  Get.back();
                                },
                                icon: const Icon(Icons.arrow_back_outlined),
                                color: AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                        GetBuilder<RequestedProductController>(
                            init: RequestedProductController(),
                            id: 'products_requested',
                            builder: (_) {
                              List<Widget> items = [];
                              for (var element
                                  in controller.products_requested) {
                                items.add(Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: ItemProduct(context, element),
                                ));
                              }
                              return controller.loading.value
                                  ? const CircularProgressIndicator()
                                  : items.isEmpty
                                      ? const RecordNotFound()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 80),
                                          child: Column(
                                            children: items,
                                          ),
                                        );
                            })
                      ],
                    )))));
  }

  Widget ItemProduct(BuildContext context, Map<String, dynamic> item) {
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
                          item["url"],
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              item["description"],
                              style: AppTheme.title,
                            ),
                            const Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text('${item["qty"]} qty'),
                                    Text(item["unit"]),
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
                                      controller.removeProduct(
                                          product_id: item["product_id"]);
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
}
