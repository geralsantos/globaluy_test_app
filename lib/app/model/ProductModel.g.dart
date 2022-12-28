// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductModel _$$_ProductModelFromJson(Map<String, dynamic> json) =>
    _$_ProductModel(
      id: json['id'] as int?,
      description: json['description'] as String,
      unit: json['unit'] as String,
      stock: json['stock'] as int,
      url: json['url'] as String,
      qty_product_requested: json['qty_product_requested'] as int? ?? 0,
    );

Map<String, dynamic> _$$_ProductModelToJson(_$_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'unit': instance.unit,
      'stock': instance.stock,
      'url': instance.url,
      'qty_product_requested': instance.qty_product_requested,
    };
