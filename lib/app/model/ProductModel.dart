import 'package:freezed_annotation/freezed_annotation.dart';

part 'ProductModel.freezed.dart';
part 'ProductModel.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    int? id,
    required String description,
    required String unit,
    required int stock,
    required String url,
    @Default(0) int qty_product_requested,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
