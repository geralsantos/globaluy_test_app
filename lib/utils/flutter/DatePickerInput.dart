import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';

class DatePickerInput extends StatefulWidget {
  DatePickerInput(
      {this.value,
      this.onFieldSubmitted,
      this.hintText,
      this.labelText,
      this.icon,
      this.controller,
      this.errorText});
  final DateTime? value;
  final Function? onFieldSubmitted;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final IconData? icon;
  final String? errorText;
  @override
  State<DatePickerInput> createState() => _DatePickerInputState();
}

class _DatePickerInputState extends State<DatePickerInput> {
  // final myController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    // myController.text = widget.value ?? '';
  }
  void showPicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: widget.value ?? DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2025),
            helpText: "Seleccione una fecha",
            cancelText: "Cancelar",
            confirmText: "Ok")
        .then((value) {
      if (widget.onFieldSubmitted != null) {
        widget.onFieldSubmitted!(DateFormat.yMd().format(value!).toString());
      }
    });
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
            : const SizedBox(),
        Card(
          // margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: TextFormField(
            readOnly: true,
            controller: widget.controller,
            // onFieldSubmitted: ,
            onTap: () {
              showPicker(context);
            },

            style: const TextStyle(fontWeight: FontWeight.normal),
            decoration: InputDecoration(
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
                fillColor: Colors.white,
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
