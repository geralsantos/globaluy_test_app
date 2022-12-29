import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:globaluy_test_app/app/model/UserModel.dart';
import 'package:globaluy_test_app/utils/flutter/AppTheme.dart';

part 'OrderModel.freezed.dart';
part 'OrderModel.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    int? id,
    required int company_id,
    required int user_id,
    required int status,
    required DateTime date_created,
    required UserModel user,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  static String getStatusString(int status) {
    String response = "Pending";
    switch (status) {
      case 1:
        response = "Pending";
        break;
      case 2:
        response = "Approved";
        break;
      case 3:
        response = "Cancelled";
        break;
    }
    return response;
  }

  static Color getStatusColor(int status) {
    Color response = AppTheme.darkText;
    switch (status) {
      case 1:
        response = AppTheme.darkText;
        break;
      case 2:
        response = AppTheme.success;
        break;
      case 3:
        response = AppTheme.error;
        break;
    }
    return response;
  }
}

enum Status {
  @JsonValue(1)
  Pending,
  @JsonValue(2)
  Approved,
  @JsonValue(2)
  Cancelled,
}
