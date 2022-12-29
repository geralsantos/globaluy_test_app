import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globaluy_test_app/app/controller/NavigationController.dart';

import 'package:globaluy_test_app/pages/dashboard/Index.dart';
import 'package:globaluy_test_app/pages/orders/Index.dart';
import 'package:globaluy_test_app/pages/request_products/Index.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';
import 'package:globaluy_test_app/utils/flutter/DialogLoading.dart';

class IndexApp extends StatefulWidget {
  IndexApp({Key? key}) : super(key: key);

  @override
  State<IndexApp> createState() => _IndexAppState();
}

class _IndexAppState extends State<IndexApp> {
  bool permission = false;
  PageController pageController = PageController(initialPage: 1);
  NavigationController navigation_controller = NavigationController();
  void initAsync(BuildContext context) async {}

  @override
  void initState() {
    super.initState();

    initAsync(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.background,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: SafeArea(
                child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  color: AppTheme.primary,
                  onPressed: () => {accountOptions(context)}),
            ))),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: RequestProductsIndex(),
            ),
            DashboardIndex(),
            OrdersIndex(),
          ],
        ),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            currentIndex: navigation_controller.navigation_index,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.inventory_rounded,
                  ),
                  label: 'Request'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_rounded), label: 'Products'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.view_in_ar), label: 'Orders'),
            ],
            onTap: (index) {
              navigation_controller.navigation_index = index;
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            },
          );
        }));
  }

  void accountOptions(BuildContext context) {
    showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 150,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppTheme.primary,
                          ),
                          child: IconButton(
                              color: AppTheme.white,
                              icon: const Icon(Icons.power_settings_new),
                              iconSize: 45.0,
                              onPressed: () {
                                ConfirmDialog('¿Do you want to log out?', () {
                                  navigation_controller.logout().then((value) {
                                    if (value) {
                                      Navigator.pushReplacementNamed(
                                          context, '/login');
                                    }
                                  });
                                }, null, context);
                              })),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Cerrar sesión'),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
