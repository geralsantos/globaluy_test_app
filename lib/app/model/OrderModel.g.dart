// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderModel _$$_OrderModelFromJson(Map<String, dynamic> json) =>
    _$_OrderModel(
      id: json['id'] as int?,
      company_id: json['company_id'] as int,
      user_id: json['user_id'] as int,
      status: json['status'] as int,
      date_created: DateTime.parse(json['date_created'] as String),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_OrderModelToJson(_$_OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.company_id,
      'user_id': instance.user_id,
      'status': instance.status,
      'date_created': instance.date_created.toIso8601String(),
      'user': instance.user,
    };
