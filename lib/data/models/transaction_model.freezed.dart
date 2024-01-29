// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get items => throw _privateConstructorUsedError;
  String get subtotal => throw _privateConstructorUsedError;
  String get adminFee => throw _privateConstructorUsedError;
  String get total => throw _privateConstructorUsedError;
  Map<String, dynamic> get paymentMethod => throw _privateConstructorUsedError;
  int get transactionTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
          TransactionModel value, $Res Function(TransactionModel) then) =
      _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call(
      {String id,
      String uid,
      List<Map<String, dynamic>> items,
      String subtotal,
      String adminFee,
      String total,
      Map<String, dynamic> paymentMethod,
      int transactionTime});
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? items = null,
    Object? subtotal = null,
    Object? adminFee = null,
    Object? total = null,
    Object? paymentMethod = null,
    Object? transactionTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as String,
      adminFee: null == adminFee
          ? _value.adminFee
          : adminFee // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      transactionTime: null == transactionTime
          ? _value.transactionTime
          : transactionTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(_$TransactionModelImpl value,
          $Res Function(_$TransactionModelImpl) then) =
      __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String uid,
      List<Map<String, dynamic>> items,
      String subtotal,
      String adminFee,
      String total,
      Map<String, dynamic> paymentMethod,
      int transactionTime});
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(_$TransactionModelImpl _value,
      $Res Function(_$TransactionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? items = null,
    Object? subtotal = null,
    Object? adminFee = null,
    Object? total = null,
    Object? paymentMethod = null,
    Object? transactionTime = null,
  }) {
    return _then(_$TransactionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as String,
      adminFee: null == adminFee
          ? _value.adminFee
          : adminFee // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value._paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      transactionTime: null == transactionTime
          ? _value.transactionTime
          : transactionTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionModelImpl implements _TransactionModel {
  const _$TransactionModelImpl(
      {required this.id,
      required this.uid,
      final List<Map<String, dynamic>> items = const [],
      required this.subtotal,
      required this.adminFee,
      required this.total,
      required final Map<String, dynamic> paymentMethod,
      required this.transactionTime})
      : _items = items,
        _paymentMethod = paymentMethod;

  factory _$TransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  final List<Map<String, dynamic>> _items;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String subtotal;
  @override
  final String adminFee;
  @override
  final String total;
  final Map<String, dynamic> _paymentMethod;
  @override
  Map<String, dynamic> get paymentMethod {
    if (_paymentMethod is EqualUnmodifiableMapView) return _paymentMethod;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paymentMethod);
  }

  @override
  final int transactionTime;

  @override
  String toString() {
    return 'TransactionModel(id: $id, uid: $uid, items: $items, subtotal: $subtotal, adminFee: $adminFee, total: $total, paymentMethod: $paymentMethod, transactionTime: $transactionTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.adminFee, adminFee) ||
                other.adminFee == adminFee) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethod, _paymentMethod) &&
            (identical(other.transactionTime, transactionTime) ||
                other.transactionTime == transactionTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      uid,
      const DeepCollectionEquality().hash(_items),
      subtotal,
      adminFee,
      total,
      const DeepCollectionEquality().hash(_paymentMethod),
      transactionTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionModelImplToJson(
      this,
    );
  }
}

abstract class _TransactionModel implements TransactionModel {
  const factory _TransactionModel(
      {required final String id,
      required final String uid,
      final List<Map<String, dynamic>> items,
      required final String subtotal,
      required final String adminFee,
      required final String total,
      required final Map<String, dynamic> paymentMethod,
      required final int transactionTime}) = _$TransactionModelImpl;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$TransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  List<Map<String, dynamic>> get items;
  @override
  String get subtotal;
  @override
  String get adminFee;
  @override
  String get total;
  @override
  Map<String, dynamic> get paymentMethod;
  @override
  int get transactionTime;
  @override
  @JsonKey(ignore: true)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
