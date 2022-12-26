import 'package:flutter/material.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';

void DialogLoading(String msj, BuildContext context,
    {bool barrierDismissible = false}) {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext bc) {
        return WillPopScope(
            onWillPop: () async => barrierDismissible,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  height: 130,
                  width: 80,
                  decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(20))
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Text(msj,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppTheme.primary),
                      )
                    ],
                  )),
            ));
      });
}

void DialogMessage(String msj, String? estado, BuildContext context) {
  final size = MediaQuery.of(context).size;
  Color color = AppTheme.error;
  IconData icon = Icons.error;
  if (estado == "success") {
    color = AppTheme.success;
    icon = Icons.check_circle_rounded;
  }
  showDialog(
      context: context,
      builder: (BuildContext bc) {
        print('msj.length ${msj.length}');
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            title: Icon(
              icon,
              color: color,
              size: 35,
            ),
            content: Text(msj,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 150,
                      padding: const EdgeInsets.only(
                          bottom: 10.0, right: 20.0, left: 20.0),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(vertical: 9.0),
                        color: AppTheme.grey,
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        elevation: 1,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: const Text("Cerrar",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AppTheme.white,
                                fontWeight: FontWeight.bold)),
                      )),
                ],
              )
            ]
            // Container(
            //     padding: const EdgeInsets.only(
            //       left: 20,
            //       right: 20,
            //     ),
            //     width: size.width,
            //     decoration: const BoxDecoration(
            //         // borderRadius: BorderRadius.all(Radius.circular(20))
            //         borderRadius: BorderRadius.all(Radius.circular(15))),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: <Widget>[
            //         const SizedBox(
            //           height: 20,
            //         ),
            //         Icon(
            //           icon,
            //           color: color,
            //           size: 35,
            //         ),
            //         const SizedBox(
            //           height: 25,
            //         ),
            //         Container(
            //             child: Expanded(
            //           child: SingleChildScrollView(
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text(msj,
            //                     textAlign: TextAlign.center,
            //                     style: const TextStyle(
            //                         fontSize: 14, fontWeight: FontWeight.bold))
            //               ],
            //             ),
            //           ),
            //         )),
            //         Container(
            //             width: 150,
            //             padding: const EdgeInsets.only(
            //                 top: 20.0, right: 20.0, left: 20.0),
            //             child: MaterialButton(
            //               padding: EdgeInsets.symmetric(vertical: 9.0),
            //               color: AppTheme.grey,
            //               onPressed: () async {
            //                 Navigator.pop(context);
            //               },
            //               elevation: 1,
            //               shape: const RoundedRectangleBorder(
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(5.0))),
            //               child: const Text("Cerrar",
            //                   style: TextStyle(
            //                       fontSize: 12.0,
            //                       color: AppTheme.white,
            //                       fontWeight: FontWeight.bold)),
            //             )),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //       ],
            //     )),
            );
      });
}

void ConfirmDialog(
    String msj, Function confirm, Function? cancel, BuildContext context) {
  final size = MediaQuery.of(context).size;

  showDialog(
      context: context,
      builder: (BuildContext bc) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: const Icon(
            Icons.help_outline,
            color: AppTheme.grey,
            size: 35,
          ),
          content: Text(msj,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 130,
                    padding: const EdgeInsets.only(
                        bottom: 10, right: 20.0, left: 20.0),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 9.0),
                      color: AppTheme.grey,
                      onPressed: () async {
                        confirm();
                      },
                      elevation: 1,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: const Text('Si',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppTheme.white,
                              fontWeight: FontWeight.bold)),
                    )),
                Container(
                    width: 130,
                    padding: const EdgeInsets.only(
                        bottom: 10, right: 20.0, left: 20.0),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 9.0),
                      color: AppTheme.primary,
                      onPressed: () async {
                        Navigator.pop(context);
                        if (cancel != null) {
                          cancel();
                        }
                      },
                      elevation: 1,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: const Text("No",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppTheme.white,
                              fontWeight: FontWeight.bold)),
                    )),
              ],
            ),
          ],
          // content: Container(
          //     padding: const EdgeInsets.only(
          //       left: 20,
          //       right: 20,
          //     ),
          //     // height: msj.length <= 60
          //     //     ? 200
          //     //     : msj.length <= 90
          //     //         ? 230
          //     //         : msj.length <= 120
          //     //             ? 240
          //     //             : msj.length <= 150
          //     //                 ? 300
          //     //                 : 400,
          //     width: size.width,
          //     decoration: const BoxDecoration(
          //         // borderRadius: BorderRadius.all(Radius.circular(20))
          //         borderRadius: BorderRadius.all(Radius.circular(15))),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisSize: MainAxisSize.min,
          //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: <Widget>[
          //         const SizedBox(
          //           height: 20,
          //         ),
          //         Icon(
          //           Icons.help_outline,
          //           color: AppTheme.grey,
          //           size: 35,
          //         ),
          //         const SizedBox(
          //           height: 25,
          //         ),
          //         Container(
          //             child: Expanded(
          //           child: SingleChildScrollView(
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(msj,
          //                     textAlign: TextAlign.center,
          //                     style: const TextStyle(
          //                         fontSize: 14, fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //           ),
          //         )),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Container(
          //                 width: 130,
          //                 padding: const EdgeInsets.only(
          //                     top: 20.0, right: 20.0, left: 20.0),
          //                 child: MaterialButton(
          //                   padding: EdgeInsets.symmetric(vertical: 9.0),
          //                   color: AppTheme.grey,
          //                   onPressed: () async {
          //                     confirm();
          //                   },
          //                   elevation: 1,
          //                   shape: const RoundedRectangleBorder(
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(5.0))),
          //                   child: Text('Si',
          //                       style: TextStyle(
          //                           fontSize: 14.0,
          //                           color: AppTheme.white,
          //                           fontWeight: FontWeight.bold)),
          //                 )),
          //             Container(
          //                 width: 130,
          //                 padding: const EdgeInsets.only(
          //                     top: 20.0, right: 20.0, left: 20.0),
          //                 child: MaterialButton(
          //                   padding: EdgeInsets.symmetric(vertical: 9.0),
          //                   color: AppTheme.primary,
          //                   onPressed: () async {
          //                     Navigator.pop(context);
          //                     if (cancel != null) {
          //                       cancel();
          //                     }
          //                   },
          //                   elevation: 1,
          //                   shape: const RoundedRectangleBorder(
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(5.0))),
          //                   child: Text("No",
          //                       style: TextStyle(
          //                           fontSize: 14.0,
          //                           color: AppTheme.white,
          //                           fontWeight: FontWeight.bold)),
          //                 )),
          //           ],
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //       ],
          //     )),
        );
      });
}
