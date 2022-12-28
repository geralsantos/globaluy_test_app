import 'package:flutter/material.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';

void SnackBarMessage(BuildContext context,
    {required String message,
    bool isSuccess = false,
    Color colorStatus = AppTheme.darkText}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            isSuccess ? Icons.thumb_up : Icons.error,
            color: Colors.white,
          ),
          const SizedBox(
            width: 7,
          ),
          Text(message)
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: colorStatus));
}
