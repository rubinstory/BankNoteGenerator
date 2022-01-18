import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_first_app/api.dart';
import 'package:my_first_app/balance/balance_model.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class BalanceAPIProvider {
  String apiKey = "Pf7HJ-5WRBgzt0eS1myGPC2DQc7WVrVqwXoLGX2R";
  String secretKey = "h0skte3bRU8qsoEUFkBUX4LBnNawMcJusbyKuNIC";
  Future<BalanceResponseModel> fetchBalance() async {
    var response = await http
        .get(Uri.parse('https://ftx.com/api/wallet/balances'), headers: {
      'FTX-KEY': apiKey,
      'FTX-SIGN': getConvertedSecretKey(),
      'FTX-TS': DateTime.now().millisecondsSinceEpoch.toString(),
    });
    if (response.statusCode == 200) {
      print(response.body);
      return BalanceResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.headers);
    }
  }

  String getConvertedSecretKey() {
    List<int> key = utf8.encode(
        DateTime.now().millisecondsSinceEpoch.toString() +
            "GET" +
            "/api/wallet/balances");
    Hmac mac = new Hmac(sha256, utf8.encode(secretKey));
    var digest = mac.convert(key);
    return digest.toString();
  }
}
