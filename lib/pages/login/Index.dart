import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:globaluy_test_app/app/controller/LoginController.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';
import 'package:globaluy_test_app/utils/flutter/DialogLoading.dart';
import 'package:globaluy_test_app/utils/dart/sharedPreferences.dart';
import 'package:globaluy_test_app/utils/flutter/HexColor.dart';
import 'package:google_sign_in/google_sign_in.dart';

sharedPreferences sharedPrefs = new sharedPreferences();

class LoginIndex extends StatefulWidget {
  LoginIndex({Key? key}) : super(key: key);
  @override
  _LoginIndexState createState() => _LoginIndexState();
}

class _LoginIndexState extends State<LoginIndex> {
  bool _showLoader = false, _showDialogResponse = false;
  String labelPassword = 'Password';
  final controller = Get.put(LoginController());
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future initData() async {
    await sharedPrefs.open();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              HexColor('#F78CB0'),
              HexColor('#F78CB0'),
              AppTheme.white,
              AppTheme.white,
            ],
          ),
        ),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: size.height,
            child: SingleChildScrollView(
                child: Container(
              height: size.height,
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'lib/resources/images/logo_horizontal.svg',
                        semanticsLabel: 'Icono',
                        width: 270,
                      ),
                      Card(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 40),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: TextFormField(
                            onChanged: (val) {
                              controller.email = val;
                            },
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black26,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          )),
                      Card(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 20),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: TextField(
                            onChanged: (val) {
                              controller.password = val;
                            },
                            obscureText: true,
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black26,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => {},
                                  icon: const Icon(Icons.visibility),
                                  color: Colors.black45,
                                ),
                                hintText: labelPassword,
                                hintStyle: const TextStyle(
                                  color: Colors.black54,
                                ),
                                fillColor: Colors.white,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          )),
                      Row(children: [
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.only(top: 10, right: 30),
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(color: AppTheme.primary),
                          ),
                        ),
                      ]),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 30.0, right: 30.0, left: 30.0, bottom: 20),
                          child: MaterialButton(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            color: AppTheme.primary,
                            onPressed: () async {
                              DialogLoading('Logging in', context);
                              print('logging in');
                              Future.delayed(Duration(milliseconds: 2000))
                                  .then((v) {
                                controller.login().then((value) {
                                  Get.back();
                                  print('value $value');
                                  if (value) {
                                    //success
                                    Navigator.pushReplacementNamed(
                                        context, '/dashboard');
                                  } else {
                                    DialogMessage('Incorrect credentials',
                                        'error', context);
                                  }
                                });
                              });
                            },
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 50,
                                ),
                                const Expanded(
                                  child: Text("Login",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          color: AppTheme.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  width: 50,
                                  padding: const EdgeInsets.only(right: 80),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppTheme.white,
                                  ),
                                )
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'or continue with',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          controller.loginGoogle().then((value) {
                            if (value) {
                              Navigator.pushNamed(context, '/dashboard');
                            }
                          });
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(10),
                          child: const Image(
                            image: AssetImage(
                                'lib/resources/images/logo_google.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 30.0, right: 30.0, left: 30.0, bottom: 20),
                          child: MaterialButton(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            color: AppTheme.white,
                            onPressed: () async {
                              // DialogLoading('Register', context);
                            },
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: AppTheme.primary,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text("Register",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 19.0,
                                        color: AppTheme.primary,
                                      )),
                                ),
                              ],
                            ),
                          )),
                    ],
                  )),
                ],
              ),
            )),
          ))
    ]);
  }
}
