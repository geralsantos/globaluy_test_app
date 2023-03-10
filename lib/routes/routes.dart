import 'package:flutter/material.dart';
import 'package:globaluy_test_app/pages/IndexApp.dart';
// import 'package:globaluy_test_app/pages/IndexApp.dart';
import 'package:globaluy_test_app/pages/login/Index.dart';
import 'package:globaluy_test_app/pages/onboarding/Onboarding.dart';
import 'package:globaluy_test_app/pages/products_requested/Index.dart';

class RouteGenerater {
  static const ONBOARDING = "/onboarding";
  static const DASHBOARD = "/dashboard";
  static const PRODUCTS_REQUESTED = "/products_requested";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ONBOARDING:
        return PageRouteBuilder(
            settings:
                settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
            pageBuilder: (_, __, ___) => OnboardingScreen(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case DASHBOARD:
        return PageRouteBuilder(
            settings:
                settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
            pageBuilder: (_, __, ___) => IndexApp(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case PRODUCTS_REQUESTED:
        return PageRouteBuilder(
            settings:
                settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
            pageBuilder: (_, __, ___) => ProductsRequestedIndex(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      default:
        return MaterialPageRoute(builder: (context) => LoginIndex());
    }
  }
}
