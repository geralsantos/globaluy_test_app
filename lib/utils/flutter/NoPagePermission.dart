import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoPagePermission extends StatefulWidget {
  NoPagePermission({Key? key}) : super(key: key);

  @override
  State<NoPagePermission> createState() => _NoPagePermissionState();
}

class _NoPagePermissionState extends State<NoPagePermission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(image: AssetImage("lib/resources/images/404.jpg")),
          Text(
            'No tienes acceso a este módulo',
            style: TextStyle(fontSize: 20),
          )
        ],
      )),
    );
  }
}
