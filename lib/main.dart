import 'package:globaluy_test_app/pages/IndexApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:globaluy_test_app/pages/login/Index.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';
import 'package:globaluy_test_app/pages/onboarding/Onboarding.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:globaluy_test_app/app/controller/LoginController.dart';

import 'routes/routes.dart';

sharedPreferences sharedPrefs = new sharedPreferences();

void main() async {
  Intl.defaultLocale = 'es';
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await sharedPrefs.open();
  await dotenv.load(fileName: ".env");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => initializeDateFormatting().then((value) {
        runApp(MyApp());
      }));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    googleSignin.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      if (account != null) {
        // user logged

      } else {
        // user NOT logged

      }
    });
  }

  Future<bool> verificarInicio() async {
    var data = false;
    data = await googleSignin.isSignedIn();
    if (!data) {
      // ignore: unrelated_type_equality_checks
      data = await sharedPrefs.read(sharedPrefs.dataUser, false) != false;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final newCheckBoxTheme = Theme.of(context).checkboxTheme.copyWith(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppTheme.primary,
        secondaryHeaderColor: AppTheme.secondary,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.android,
        fontFamily: 'Poppins',
      ).copyWith(checkboxTheme: newCheckBoxTheme),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      home: FutureBuilder(
          future: verificarInicio(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return SafeArea(child: IndexApp());
            } else {
              return OnboardingScreen();
            }
          }),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginIndex(),
        '/onBoarding': (BuildContext context) => OnboardingScreen(),
      },
      onGenerateRoute: RouteGenerater.generateRoute,
      navigatorKey: GlobalKey(),
    );
  }
}
