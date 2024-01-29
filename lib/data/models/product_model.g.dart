// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      quantity: json['quantity'] as int? ?? 0,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'images': instance.images,
      'quantity': instance.quantity,
    };
