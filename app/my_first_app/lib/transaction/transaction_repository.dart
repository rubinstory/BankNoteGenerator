import 'package:my_first_app/transaction/transaction.dart';
import 'package:my_first_app/transaction/transcation_api_provider.dart';

class TransactionRepository {
  final transactionAPIProvider = TransactionAPIProvider();
  Future<List<TranscationModel>> fetchTransactionList() =>
      transactionAPIProvider.fetchTransactionList();
}
