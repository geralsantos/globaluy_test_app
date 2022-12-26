import 'package:flutter/material.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';

class TextFieldPasswordInput extends StatefulWidget {
  TextFieldPasswordInput(
      {required this.onChanged,
      this.hintText,
      required this.labelText,
      this.controller,
      this.suffixButton,
      required this.obscureText,
      this.errorText});
  final Function onChanged;
  final String? hintText;
  final String labelText;
  final TextEditingController? controller;

  final IconButton? suffixButton;
  final bool obscureText;
  final String? errorText;

  @override
  State<TextFieldPasswordInput> createState() => _TextFieldPasswordInputState();
}

class _TextFieldPasswordInputState extends State<TextFieldPasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            widget.labelText,
            textAlign: TextAlign.left,
          ),
        ),
        Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: TextFormField(
              controller: widget.controller,
              onChanged: (val) {
                widget.onChanged(val);
              },
              obscureText: widget.obscureText,
              style: const TextStyle(fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.black26,
                  ),
                  suffixIcon: widget.suffixButton,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                  ),
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 16.0)),
            )),
        Padding(
          padding: EdgeInsets.only(
              left: 10,
              bottom:
                  widget.errorText != null && widget.errorText != "" ? 10 : 5),
          child: Text(
            widget.errorText ?? '',
            textAlign: TextAlign.left,
            style: TextStyle(color: AppTheme.error),
          ),
        ),
      ],
    );
  }
}
