// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:globaluy_test_app/app/exceptions/AuthException.dart';
// import 'package:globaluy_test_app/app/models/User.dart';
// import 'package:globaluy_test_app/app/provider/DashboardProvider.dart';
// import 'package:globaluy_test_app/pages/dashboard/widgets/Transaction/Index.dart';
// import 'package:globaluy_test_app/pages/dashboard/widgets/TransactionChart.dart';
// import 'package:globaluy_test_app/pages/dashboard/widgets/DashboardNotices.dart';
// import 'package:globaluy_test_app/utils/dart/Utils.dart';
// import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';

// class DashboardIndex extends StatefulWidget {
//   const DashboardIndex({Key? key}) : super(key: key);

//   @override
//   State<DashboardIndex> createState() => _DashboardIndexState();
// }

// class _DashboardIndexState extends State<DashboardIndex> {
//   final dashboardProvider =
//       ChangeNotifierProvider((ref) => DashboardProvider());
//   sharedPreferences sharedPrefs = sharedPreferences();
//   User user = User();
//   bool permission_transactions_list = false;
//   bool permission_dashboard_business = false;
//   void init() {
//     try {
//       sharedPrefs.checkUser().then((value) => user = User.fromJson(value));
//     } on AuthException catch (e) {
//       sharedPrefs.clearSesion();
//       Navigator.pushReplacementNamed(context, '/login');
//     } catch (e) {}
//   }

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     final dashboardFutureProvider =
//         FutureProvider((ref) => DashboardProvider().init(context));
//     return SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Container(
//           padding: const EdgeInsets.only(left: 13, right: 13),
//           child: Consumer(builder: (context, ref, child) {
//             final result = ref.watch(dashboardFutureProvider);
//             final businessName = ref
//                 .watch(DashboardProvider.provider)
//                 .business_actual
//                 .businessName;
//             return result.when(
//                 data: (value) {
//                   value.businessName = businessName ?? value.businessName;
//                   permission_transactions_list =
//                       Utils.havePermission(user, Permission.TRANSACTIONS);
//                   permission_dashboard_business =
//                       Utils.havePermission(user, Permission.DASHBOARD_BUSINESS);

//                   return Column(
//                     children: [
//                       Container(
//                           margin: const EdgeInsets.only(top: 12, bottom: 7),
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Hola ${value.businessName}',
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w500, fontSize: 16),
//                           )),
//                       SizedBox(
//                         child: DashboardNotices(),
//                       ),
//                       Column(
//                         children: [
//                           permission_dashboard_business
//                               ? SizedBox(
//                                   child: TransactionChart(),
//                                 )
//                               : const SizedBox(),
//                           permission_dashboard_business ||
//                                   permission_transactions_list
//                               ? SizedBox(
//                                   child: Transactions(),
//                                 )
//                               : const SizedBox()
//                         ],
//                       ),
//                     ],
//                   );
//                 },
//                 error: (e, st) {
//                   return Text('$e');
//                 },
//                 loading: () => SizedBox());
//           }),
//         ));
//   }
// }
