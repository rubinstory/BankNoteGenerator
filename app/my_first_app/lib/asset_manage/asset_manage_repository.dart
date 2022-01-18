import 'package:my_first_app/api.dart';
import 'package:my_first_app/asset_manage/asset_manage.dart';
import 'package:my_first_app/asset_manage/asset_manage_api_provider.dart';

class AssetManageRepository {
  final assetManageAPIProvider = AssetManageAPIProvider();
  Future<AssetManageModel> fetchAssetManageItem(int userId) =>
      assetManageAPIProvider.fetchAssetManageItem(userId);

  Future<AssetManageModel> updateAssetManageItem(AssetManageModel model) =>
      assetManageAPIProvider.updateAssetManageItem(model);
}
