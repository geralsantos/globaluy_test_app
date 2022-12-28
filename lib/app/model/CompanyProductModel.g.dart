// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CompanyProductModel _$$_CompanyProductModelFromJson(
        Map<String, dynamic> json) =>
    _$_CompanyProductModel(
      id: json['id'] as int?,
      company_id: json['company_id'] as int,
      product_id: json['product_id'] as int,
      quantity: json['quantity'] as int,
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CompanyProductModelToJson(
        _$_CompanyProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.company_id,
      'product_id': instance.product_id,
      'quantity': instance.quantity,
      'product': instance.product,
    };
