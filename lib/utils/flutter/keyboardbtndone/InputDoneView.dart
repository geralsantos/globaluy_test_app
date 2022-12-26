import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputDoneView extends StatelessWidget {
  const InputDoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: CupertinoColors.extraLightBackgroundGray,
        child: Align(
            alignment: Alignment.topRight,
            child: CupertinoButton(
              padding:
                  const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Text("Aceptar",
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                  )),
            )));
  }
}
