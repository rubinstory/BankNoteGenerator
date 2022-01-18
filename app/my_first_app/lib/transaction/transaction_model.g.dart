// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      market: json['market'] as String,
      side: json['side'] as String,
      size: (json['size'] as num).toDouble(),
      avgFillPrice: (json['avgFillPrice'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
      user: json['user'] as int,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'market': instance.market,
      'side': instance.side,
      'size': instance.size,
      'avgFillPrice': instance.avgFillPrice,
      'createdAt': instance.createdAt,
      'user': instance.user,
    };
