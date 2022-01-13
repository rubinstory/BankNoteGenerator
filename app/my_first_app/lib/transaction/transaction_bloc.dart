import 'package:my_first_app/transaction/transaction.dart';
import 'package:my_first_app/transaction/transaction_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class TransactionBloc {
  final _repository = TransactionRepository();
  final _transactionFetcher = PublishSubject<List<TranscationModel>>();
  Stream<List<TranscationModel>> get allTransactions =>
      _transactionFetcher.stream;

  fetchAllTransaction() async {
    List<TranscationModel> transactionList =
        await _repository.fetchTransactionList();
    _transactionFetcher.sink.add(transactionList);
  }

  dispose() {
    _transactionFetcher.close();
  }
}

final transactionBloc = TransactionBloc();
