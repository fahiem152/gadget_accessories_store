// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
      subtotal: json['subtotal'] as String,
      adminFee: json['adminFee'] as String,
      total: json['total'] as String,
      paymentMethod: json['paymentMethod'] as Map<String, dynamic>,
      transactionTime: json['transactionTime'] as int,
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'items': instance.items,
      'subtotal': instance.subtotal,
      'adminFee': instance.adminFee,
      'total': instance.total,
      'paymentMethod': instance.paymentMethod,
      'transactionTime': instance.transactionTime,
    };
