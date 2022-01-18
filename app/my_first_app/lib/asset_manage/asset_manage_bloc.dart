import 'package:my_first_app/api.dart';
import 'package:my_first_app/asset_manage/asset_manage.dart';
import 'package:my_first_app/asset_manage/asset_manage_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

class AssetManageBloc {
  final _repository = AssetManageRepository();
  final _assetManageFetcher = PublishSubject<AssetManageModel>();
  Stream<AssetManageModel> get currentUserAssetManageItem =>
      _assetManageFetcher.stream;

  fetchAssetManageItem(int userId) async {
    AssetManageModel assetManageModel =
        await _repository.fetchAssetManageItem(userId);
    _assetManageFetcher.sink.add(assetManageModel);
  }

  updateAssetManageItem(AssetManageModel model) async {
    AssetManageModel assetManageModel =
        await _repository.updateAssetManageItem(model);
    _assetManageFetcher.sink.add(assetManageModel);
  }

  dispose() {
    _assetManageFetcher.close();
  }
}

final assetManageBloc = AssetManageBloc();
