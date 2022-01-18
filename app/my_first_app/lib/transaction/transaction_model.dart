import 'package:json_annotation/json_annotation.dart';
part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  String market;
  String side;
  double size;
  double avgFillPrice;
  String createdAt;
  int user;

  TransactionModel({
    required this.market,
    required this.side,
    required this.size,
    required this.avgFillPrice,
    required this.createdAt,
    required this.user,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
