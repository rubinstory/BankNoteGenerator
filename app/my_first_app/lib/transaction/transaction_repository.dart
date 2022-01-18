import 'package:my_first_app/transaction/transaction_api_provider.dart';
import 'package:my_first_app/transaction/transaction_model.dart';

class TransactionRepository {
  final transactionAPIProvider = TransactionAPIProvider();

  Future<List<TransactionModel>> fetchTransactionList(int userId) =>
      transactionAPIProvider.fetchTransactionList(userId);
}
