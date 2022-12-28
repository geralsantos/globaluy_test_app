// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'CompanyProductModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CompanyProductModel _$CompanyProductModelFromJson(Map<String, dynamic> json) {
  return _CompanyProductModel.fromJson(json);
}

/// @nodoc
mixin _$CompanyProductModel {
  int? get id => throw _privateConstructorUsedError;
  int get company_id => throw _privateConstructorUsedError;
  int get product_id => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  ProductModel get product => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyProductModelCopyWith<CompanyProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyProductModelCopyWith<$Res> {
  factory $CompanyProductModelCopyWith(
          CompanyProductModel value, $Res Function(CompanyProductModel) then) =
      _$CompanyProductModelCopyWithImpl<$Res, CompanyProductModel>;
  @useResult
  $Res call(
      {int? id,
      int company_id,
      int product_id,
      int quantity,
      ProductModel product});

  $ProductModelCopyWith<$Res> get product;
}

/// @nodoc
class _$CompanyProductModelCopyWithImpl<$Res, $Val extends CompanyProductModel>
    implements $CompanyProductModelCopyWith<$Res> {
  _$CompanyProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? company_id = null,
    Object? product_id = null,
    Object? quantity = null,
    Object? product = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      company_id: null == company_id
          ? _value.company_id
          : company_id // ignore: cast_nullable_to_non_nullable
              as int,
      product_id: null == product_id
          ? _value.product_id
          : product_id // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res> get product {
    return $ProductModelCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CompanyProductModelCopyWith<$Res>
    implements $CompanyProductModelCopyWith<$Res> {
  factory _$$_CompanyProductModelCopyWith(_$_CompanyProductModel value,
          $Res Function(_$_CompanyProductModel) then) =
      __$$_CompanyProductModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int company_id,
      int product_id,
      int quantity,
      ProductModel product});

  @override
  $ProductModelCopyWith<$Res> get product;
}

/// @nodoc
class __$$_CompanyProductModelCopyWithImpl<$Res>
    extends _$CompanyProductModelCopyWithImpl<$Res, _$_CompanyProductModel>
    implements _$$_CompanyProductModelCopyWith<$Res> {
  __$$_CompanyProductModelCopyWithImpl(_$_CompanyProductModel _value,
      $Res Function(_$_CompanyProductModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? company_id = null,
    Object? product_id = null,
    Object? quantity = null,
    Object? product = null,
  }) {
    return _then(_$_CompanyProductModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      company_id: null == company_id
          ? _value.company_id
          : company_id // ignore: cast_nullable_to_non_nullable
              as int,
      product_id: null == product_id
          ? _value.product_id
          : product_id // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CompanyProductModel implements _CompanyProductModel {
  const _$_CompanyProductModel(
      {this.id,
      required this.company_id,
      required this.product_id,
      required this.quantity,
      required this.product});

  factory _$_CompanyProductModel.fromJson(Map<String, dynamic> json) =>
      _$$_CompanyProductModelFromJson(json);

  @override
  final int? id;
  @override
  final int company_id;
  @override
  final int product_id;
  @override
  final int quantity;
  @override
  final ProductModel product;

  @override
  String toString() {
    return 'CompanyProductModel(id: $id, company_id: $company_id, product_id: $product_id, quantity: $quantity, product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompanyProductModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.company_id, company_id) ||
                other.company_id == company_id) &&
            (identical(other.product_id, product_id) ||
                other.product_id == product_id) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, company_id, product_id, quantity, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CompanyProductModelCopyWith<_$_CompanyProductModel> get copyWith =>
      __$$_CompanyProductModelCopyWithImpl<_$_CompanyProductModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompanyProductModelToJson(
      this,
    );
  }
}

abstract class _CompanyProductModel implements CompanyProductModel {
  const factory _CompanyProductModel(
      {final int? id,
      required final int company_id,
      required final int product_id,
      required final int quantity,
      required final ProductModel product}) = _$_CompanyProductModel;

  factory _CompanyProductModel.fromJson(Map<String, dynamic> json) =
      _$_CompanyProductModel.fromJson;

  @override
  int? get id;
  @override
  int get company_id;
  @override
  int get product_id;
  @override
  int get quantity;
  @override
  ProductModel get product;
  @override
  @JsonKey(ignore: true)
  _$$_CompanyProductModelCopyWith<_$_CompanyProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}
