import 'package:freezed_annotation/freezed_annotation.dart';

part 'UserModel.freezed.dart';
part 'UserModel.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    int? id,
    required int rol_id,
    required String full_name,
    required String user_code,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
