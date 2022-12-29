import 'package:flutter/material.dart';
import 'package:globaluy_test_app/app/exceptions/AuthException.dart';
import 'package:globaluy_test_app/pages/products/Index.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';

class DashboardIndex extends StatefulWidget {
  const DashboardIndex({Key? key}) : super(key: key);

  @override
  State<DashboardIndex> createState() => _DashboardIndexState();
}

class _DashboardIndexState extends State<DashboardIndex> {
  sharedPreferences sharedPrefs = sharedPreferences();
  void init() {
    try {
      // sharedPrefs.checkUser().then((value) => user = User.fromJson(value));
    } on AuthException catch (e) {
      sharedPrefs.clearSesion();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Column(children: [
              SizedBox(
                child: ProductsIndex(),
              ),
            ])));
  }
}
