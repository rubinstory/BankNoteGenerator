import 'package:json_annotation/json_annotation.dart';
part 'balance_model.g.dart';

@JsonSerializable()
class BalanceModel {
  String coin;
  double total;
  double free;
  double availableWithoutBorrow;
  double usdValue;
  double spotBorrow;

  BalanceModel({
    required this.coin,
    required this.total,
    required this.free,
    required this.availableWithoutBorrow,
    required this.usdValue,
    required this.spotBorrow,
  });
  factory BalanceModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceModelFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceModelToJson(this);
}

@JsonSerializable()
class BalanceResponseModel {
  bool success;
  List<BalanceModel> result;

  BalanceResponseModel({
    required this.success,
    required this.result,
  });

  factory BalanceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceResponseModelToJson(this);
}
