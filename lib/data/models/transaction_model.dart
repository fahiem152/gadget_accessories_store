import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String uid,
    @Default([]) List<Map<String, dynamic>> items,
    required String subtotal,
    required String adminFee,
    required String total,
    required Map<String, dynamic> paymentMethod,
    required int transactionTime,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
