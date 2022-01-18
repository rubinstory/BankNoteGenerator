import 'package:my_first_app/transaction/transaction_model.dart';
import 'package:my_first_app/transaction/transaction_repository.dart';
import 'package:rxdart/rxdart.dart';

class TransactionBloc {
  final _repository = TransactionRepository();
  final _transactionFetcher = PublishSubject<List<TransactionModel>>();

  Stream<List<TransactionModel>> get currentUserTransactionList =>
      _transactionFetcher.stream;

  fetchTransactionList(int userId) async {
    List<TransactionModel> list =
        await _repository.fetchTransactionList(userId);
    _transactionFetcher.sink.add(list);
  }

  dispose() {
    _transactionFetcher.close();
  }
}

final transactionBloc = TransactionBloc();
