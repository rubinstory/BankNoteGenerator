import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_first_app/transaction/transaction.dart';

class TransactionAPIProvider {
  Client client = Client();
  final String base_url = "http://127.0.0.1:8000/";

  get transactionListURL => base_url + "transaction";

  Future<List<TranscationModel>> fetchTransactionList() async {
    final response = await client.get(Uri.parse(transactionListURL));
    if (response.statusCode == 200) {
      List<TranscationModel> _list = [];
      for (var body in jsonDecode(response.body)) {
        _list.add(TranscationModel.fromJson(body));
      }

      return _list;
    } else {
      throw Exception("Transaction Error");
    }
  }
}
