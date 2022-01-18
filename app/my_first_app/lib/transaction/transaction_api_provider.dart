import 'package:my_first_app/api.dart';
import 'package:my_first_app/transaction/transaction_model.dart';
import 'package:dio/dio.dart';

class TransactionAPIProvider {
  Future<List<TransactionModel>> fetchTransactionList(int userId) async {
    final response = RestClient(Dio()).fetchTransactionList(userId);
    return response;
  }
}
