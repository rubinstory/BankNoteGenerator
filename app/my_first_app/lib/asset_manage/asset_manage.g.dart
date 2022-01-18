// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_manage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetManageModel _$AssetManageModelFromJson(Map<String, dynamic> json) =>
    AssetManageModel(
      algorithm_type: json['algorithm_type'] as String,
      automatic_investment_status: json['automatic_investment_status'] as bool,
      answer_to_question_1: json['answer_to_question_1'] as int,
      answer_to_question_2: json['answer_to_question_2'] as int,
      answer_to_question_3: json['answer_to_question_3'] as int,
      user: json['user'] as int,
    );

Map<String, dynamic> _$AssetManageModelToJson(AssetManageModel instance) =>
    <String, dynamic>{
      'algorithm_type': instance.algorithm_type,
      'automatic_investment_status': instance.automatic_investment_status,
      'answer_to_question_1': instance.answer_to_question_1,
      'answer_to_question_2': instance.answer_to_question_2,
      'answer_to_question_3': instance.answer_to_question_3,
      'user': instance.user,
    };
