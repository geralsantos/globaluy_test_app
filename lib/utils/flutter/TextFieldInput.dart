import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';
import 'package:globaluy_test_app/utils/flutter/keyboardbtndone/KeyboardOverlay.dart';

class TextFieldInput extends StatefulWidget {
  TextFieldInput(
      {this.onChanged,
      this.onFieldSubmitted,
      this.onTap,
      this.hintText,
      this.labelText,
      this.icon,
      this.suffixIcon,
      this.suffixIconColor,
      this.suffixIconMultiple,
      this.controller,
      this.errorText,
      this.maxLines,
      this.textInputType,
      this.readOnly,
      this.fillColor,
      this.textColor,
      //this.focusNode,
      this.inputFormatters,
      this.maxLength});
  final Function? onChanged;
  final Function? onFieldSubmitted;
  final Function? onTap;

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final IconData? icon;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final Widget? suffixIconMultiple;

  final String? errorText;
  final int? maxLines;
  final dynamic textInputType;
  final bool? readOnly;
  final Color? fillColor;
  final Color? textColor;
  //final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  // final myController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
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
                  ].contains(widget.textInputType) ||
              widget.maxLines != null)) {
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
        Card(
          // margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: TextFormField(
            inputFormatters: widget.inputFormatters,
            focusNode: focusNode,
            keyboardType: widget.textInputType,

            maxLines: widget.maxLines ?? 1,
            maxLength: widget.maxLength,
            controller: widget.controller,
            // onFieldSubmitted: ,
            onFieldSubmitted: (val) => widget.onFieldSubmitted!(val),
            onChanged: (val) {
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              }
            },
            onTap: () => widget.onTap!(),
            readOnly: widget.readOnly ?? false,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: widget.textColor ?? Colors.black),
            decoration: InputDecoration(
                suffixIcon: widget.suffixIconMultiple ??
                    (widget.suffixIcon != null
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
                filled: true,
                fillColor: widget.fillColor ?? Colors.white,
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(10.0),
                    //     topRight: Radius.circular(10.0)),
                    ),
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
                  textAlign: TextAlign.left,
                  style: TextStyle(color: AppTheme.error),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
