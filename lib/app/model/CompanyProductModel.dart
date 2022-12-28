import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:globaluy_test_app/app/model/ProductModel.dart';

part 'CompanyProductModel.freezed.dart';
part 'CompanyProductModel.g.dart';

@freezed
class CompanyProductModel with _$CompanyProductModel {
  const factory CompanyProductModel({
    int? id,
    required int company_id,
    required int product_id,
    required int quantity,
    required ProductModel product,
  }) = _CompanyProductModel;

  factory CompanyProductModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyProductModelFromJson(json);
}
