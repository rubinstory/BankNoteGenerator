import 'package:my_first_app/asset_manage/asset_manage.dart';
import 'package:my_first_app/balance/balance_model.dart';
import 'package:my_first_app/transaction/transaction_model.dart';
import 'package:my_first_app/user/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api.g.dart';

int CURRENT_USER_ID = 1;

@RestApi(baseUrl: "http://192.249.18.201:80/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('user/{user_id}')
  Future<UserModel> fetchCurrentUser(@Path('user_id') int userId);

  @GET('asset_manage/{user_id}')
  Future<AssetManageModel> fetchAssetManageItem(@Path('user_id') int userId);

  @POST('asset_manage/')
  Future<AssetManageModel> updateAssetManageModel(
    @Body() AssetManageModel assetManageModel,
  );

  @GET('transaction/')
  Future<List<TransactionModel>> fetchTransactionList(
      @Query('user') int userId);
}
