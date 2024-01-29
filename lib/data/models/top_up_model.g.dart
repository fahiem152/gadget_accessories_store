// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TopUpModelImpl _$$TopUpModelImplFromJson(Map<String, dynamic> json) =>
    _$TopUpModelImpl(
      uid: json['uid'] as String,
      timestamp: json['timestamp'] as int,
      amount: json['amount'] as int,
      status: json['status'] as String,
      userUid: json['userUid'] as String,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$$TopUpModelImplToJson(_$TopUpModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'timestamp': instance.timestamp,
      'amount': instance.amount,
      'status': instance.status,
      'userUid': instance.userUid,
      'userName': instance.userName,
    };
