import 'package:json_annotation/json_annotation.dart';
part 'asset_manage.g.dart';

@JsonSerializable()
class AssetManageModel {
  String algorithm_type;
  bool automatic_investment_status = false;
  int answer_to_question_1 = 0;
  int answer_to_question_2 = 0;
  int answer_to_question_3 = 0;
  int user = 0;

  AssetManageModel({
    required this.algorithm_type,
    required this.automatic_investment_status,
    required this.answer_to_question_1,
    required this.answer_to_question_2,
    required this.answer_to_question_3,
    required this.user,
  });

  factory AssetManageModel.fromJson(Map<String, dynamic> json) =>
      _$AssetManageModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssetManageModelToJson(this);
}
