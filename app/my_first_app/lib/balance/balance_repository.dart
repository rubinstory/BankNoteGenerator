import 'package:my_first_app/balance/balance_api_provider.dart';
import 'package:my_first_app/balance/balance_model.dart';

class BalanceRepository {
  final balanceAPIProvider = BalanceAPIProvider();
  Future<BalanceResponseModel> fetchBalances() =>
      balanceAPIProvider.fetchBalance();
}
