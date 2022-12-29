import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globaluy_test_app/app/controller/OrderController.dart';
import 'package:globaluy_test_app/app/model/OrderModel.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';
import 'package:globaluy_test_app/utils/flutter/DialogLoading.dart';
import 'package:globaluy_test_app/utils/flutter/RecordNotFound.dart';
import 'package:globaluy_test_app/utils/flutter/ShimmerProduct.dart';
import 'package:globaluy_test_app/utils/flutter/SnackBarMessage.dart';
import 'package:intl/intl.dart';

class OrdersIndex extends StatefulWidget {
  const OrdersIndex({super.key});

  @override
  State<OrdersIndex> createState() => _OrdersIndexState();
}

class _OrdersIndexState extends State<OrdersIndex> {
  List<Widget> shimmerProducts = [
    const ShimmerProduct(),
    const ShimmerProduct(),
    const ShimmerProduct(),
    const ShimmerProduct(),
    const ShimmerProduct(),
    const ShimmerProduct(),
    const ShimmerProduct(),
  ];
  @override
  void initState() {
    super.initState();
    orderController.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScrollController _controller = new ScrollController();

    return Scaffold(
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 8),
                child: Row(
                  children: const [
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Orders',
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: AppTheme.title,
                          )),
                    ),
                  ],
                ),
              ),
              GetBuilder<OrderController>(
                  init: OrderController(),
                  id: 'order_items',
                  builder: (_) {
                    List<Widget> items = [];
                    for (var element in orderController.order_items) {
                      items.add(Padding(
                        padding: const EdgeInsets.all(6),
                        child: ItemProduct(context, element),
                      ));
                    }
                    return orderController.loading.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 80),
                            child: Column(
                              children: shimmerProducts,
                            ),
                          )
                        : items.isEmpty
                            ? const RecordNotFound()
                            : Column(
                                children: [
                                  const Text('Click one order to process it'),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 80),
                                    child: Column(
                                      children: items,
                                    ),
                                  )
                                ],
                              );
                  }),
              // Obx(() {
              //   List<Widget> items = [];
              //   for (var element in orderController.order_items) {
              //     items.add(Padding(
              //       padding: const EdgeInsets.all(6),
              //       child: ItemProduct(context, element),
              //     ));
              //   }
              //   return orderController.loading.value
              //       ? const CircularProgressIndicator()
              //       : items.isEmpty
              //           ? const RecordNotFound()
              //           : Column(
              //               children: [
              //                 const Text('Click one order to process it'),
              //                 Padding(
              //                   padding: EdgeInsets.only(bottom: 80),
              //                   child: Column(
              //                     children: items,
              //                   ),
              //                 )
              //               ],
              //             );
              // })
            ],
          )),
    );
  }

  Widget ItemProduct(BuildContext context, OrderModel item) {
    final size = MediaQuery.of(context).size;
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () async {
            if (OrderModel.getStatusString(item.status) != 'Pending') {
              return;
            }
            moreOptions(context, item);
          },
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
                  height: 130,
                  padding: const EdgeInsets.only(right: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 80,
                        child: Icon(
                          Icons.view_in_ar,
                          size: 80,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Pedido #${item.id}',
                              style: AppTheme.title,
                            ),
                            const Spacer(),
                            Text(
                                'Realizado el ${DateFormat.yMd().add_Hm().format(DateTime.parse(item.date_created.toString()))}'),
                            Text(
                              '${item.user.full_name}',
                            ),
                            Text('${item.user.user_code}'),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        OrderModel.getStatusColor(item.status),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 5, bottom: 5),
                                  child: Row(children: [
                                    Text(
                                      OrderModel.getStatusString(item.status),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            )
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

  void moreOptions(BuildContext context, OrderModel item) {
    showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        child: Text(
                      'Pedido #${item.id}',
                      style: AppTheme.title,
                    )),
                    const SizedBox(
                      height: 10,
                    ),
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
                          if (OrderModel.getStatusString(item.status) !=
                              'Pending') {
                            return;
                          }
                          DialogLoading('Processing order', context);
                          orderController.processOrder(item).then((value) {
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
                        },
                        child: const Text(
                          'Process order',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
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
