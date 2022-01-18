import 'package:my_first_app/balance/balance_model.dart';
import 'package:my_first_app/balance/balance_repository.dart';
import 'package:rxdart/subjects.dart';

class BalanceBloc {
  final _repository = BalanceRepository();
  final _balanceFetcher = PublishSubject<BalanceResponseModel>();
  Stream<BalanceResponseModel> get balanceList => _balanceFetcher.stream;

  fetchBalances() async {
    BalanceResponseModel balanceResponseModel =
        await _repository.fetchBalances();
    _balanceFetcher.sink.add(balanceResponseModel);
  }

  dispose() {
    _balanceFetcher.close();
  }
}

final balanceBloc = BalanceBloc();
