import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';
import 'package:globaluy_test_app/utils/flutter/keyboardbtndone/KeyboardOverlay.dart';

class TextFieldInputAmountFormatter extends StatefulWidget {
  TextFieldInputAmountFormatter({
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.hintText,
    this.labelText,
    this.icon,
    this.suffixIcon,
    this.suffixIconColor,
    required this.controller,
    this.errorText,
    this.textInputType,
    this.readOnly,
    this.fillColor,
    this.textColor,
    //this.focusNode,
    this.inputFormatters,
  });
  final Function? onChanged;
  final Function? onFieldSubmitted;
  final Function? onTap;

  final String? hintText;
  final String? labelText;
  final TextEditingController controller;
  final IconData? icon;
  final IconData? suffixIcon;
  final Color? suffixIconColor;

  final String? errorText;
  final dynamic textInputType;
  final bool? readOnly;
  final Color? fillColor;
  final Color? textColor;
  //final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;

  Timer? t;
  String lastInputValue = "";
  @override
  State<TextFieldInputAmountFormatter> createState() =>
      _TextFieldInputAmountFormatterState();
}

class _TextFieldInputAmountFormatterState
    extends State<TextFieldInputAmountFormatter> {
  // final myController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      bool hasFocus = focusNode.hasFocus;
      if (hasFocus &&
          (widget.textInputType != null &&
              [
                const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                const TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                const TextInputType.numberWithOptions(
                    decimal: false, signed: true),
                TextInputType.number
              ].contains(widget.textInputType))) {
        KeyboardOverlay.showOverlay(context);
      } else {
        KeyboardOverlay.removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null
            ? Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '${widget.labelText}',
                  textAlign: TextAlign.left,
                ))
            : SizedBox(),
        Container(
          child: TextFormField(
            inputFormatters: widget.inputFormatters,
            focusNode: focusNode,
            keyboardType: widget.textInputType,

            controller: widget.controller,
            // onFieldSubmitted: ,
            onFieldSubmitted: (val) {
              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted!(val);
              }
            },
            onChanged: (v) {
              if (widget.lastInputValue != v) {
                widget.lastInputValue = v;
                if (widget.t != null) {
                  widget.t!.cancel();
                }
                widget.t = Timer(const Duration(milliseconds: 500), () {
                  String value = v.toString().replaceAll(RegExp(r'\D'), '');
                  widget.controller.text = int.parse(value)
                      .toString()
                      .replaceAllMapped(RegExp(r'([0-9])([0-9]{2})$'), (match) {
                    return '${match[1]}.${match[2]}';
                  });
                  widget.controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: widget.controller.text.length));
                });
              }
              if (widget.onChanged != null) {
                widget.onChanged!(v);
              }
            },
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            readOnly: widget.readOnly ?? false,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 50,
                color: widget.textColor ?? Color.fromARGB(255, 56, 55, 55)),
            decoration: InputDecoration(
                suffixIcon: (widget.suffixIcon != null
                    ? Icon(
                        widget.suffixIcon,
                        color: widget.suffixIconColor ?? Colors.black26,
                      )
                    : null),
                prefixIcon: widget.icon != null
                    ? Icon(
                        widget.icon,
                        color: Colors.black26,
                      )
                    : null,
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: Colors.black54,
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0)),
          ),
        ),
        widget.errorText != null && widget.errorText != ''
            ? Padding(
                padding: EdgeInsets.only(
                    left: 10,
                    bottom: widget.errorText != null && widget.errorText != ""
                        ? 10
                        : 5),
                child: Text(
                  widget.errorText ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppTheme.error),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
