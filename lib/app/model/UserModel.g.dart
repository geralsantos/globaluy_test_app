// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      id: json['id'] as int?,
      rol_id: json['rol_id'] as int,
      full_name: json['full_name'] as String,
      user_code: json['user_code'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rol_id': instance.rol_id,
      'full_name': instance.full_name,
      'user_code': instance.user_code,
      'email': instance.email,
    };
