import 'package:dio/dio.dart';
import 'package:my_first_app/api.dart';
import 'package:my_first_app/asset_manage/asset_manage.dart';

class AssetManageAPIProvider {
  Future<AssetManageModel> fetchAssetManageItem(int userId) async {
    final response = RestClient(Dio()).fetchAssetManageItem(userId);
    return response;
  }

  Future<AssetManageModel> updateAssetManageItem(AssetManageModel model) async {
    final response = await RestClient(Dio()).updateAssetManageModel(model);
    return response;
  }
}
