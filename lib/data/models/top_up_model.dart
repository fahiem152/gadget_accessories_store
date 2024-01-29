import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_up_model.freezed.dart';
part 'top_up_model.g.dart';

@freezed
class TopUpModel with _$TopUpModel {
  const factory TopUpModel({
    required String uid,
    required int timestamp,
    required int amount,
    required String status,
    required String userUid,
    required String userName,
  }) = _TopUpModel;

  factory TopUpModel.fromJson(Map<String, dynamic> json) =>
      _$TopUpModelFromJson(json);
}
