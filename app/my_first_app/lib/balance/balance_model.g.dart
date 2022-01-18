// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceModel _$BalanceModelFromJson(Map<String, dynamic> json) => BalanceModel(
      coin: json['coin'] as String,
      total: (json['total'] as num).toDouble(),
      free: (json['free'] as num).toDouble(),
      availableWithoutBorrow:
          (json['availableWithoutBorrow'] as num).toDouble(),
      usdValue: (json['usdValue'] as num).toDouble(),
      spotBorrow: (json['spotBorrow'] as num).toDouble(),
    );

Map<String, dynamic> _$BalanceModelToJson(BalanceModel instance) =>
    <String, dynamic>{
      'coin': instance.coin,
      'total': instance.total,
      'free': instance.free,
      'availableWithoutBorrow': instance.availableWithoutBorrow,
      'usdValue': instance.usdValue,
      'spotBorrow': instance.spotBorrow,
    };

BalanceResponseModel _$BalanceResponseModelFromJson(
        Map<String, dynamic> json) =>
    BalanceResponseModel(
      success: json['success'] as bool,
      result: (json['result'] as List<dynamic>)
          .map((e) => BalanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BalanceResponseModelToJson(
        BalanceResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
