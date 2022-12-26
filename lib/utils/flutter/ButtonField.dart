import 'package:flutter/material.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';

// ignore: must_be_immutable
class ButtonField extends StatelessWidget {
  ButtonField(
      {Key? key, required this.textButton, this.color, required this.onPressed})
      : super(key: key);
  final String textButton;
  final Function onPressed;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.only(top: 30.0, right: 30.0, left: 30.0, bottom: 20),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        color: color ?? AppTheme.primary,
        onPressed: () {
          onPressed();
        },
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Text(textButton,
            style: const TextStyle(
                fontSize: 19.0,
                color: AppTheme.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
