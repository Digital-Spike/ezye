import 'dart:convert';

import 'package:ezys/model/transaction.dart';
import 'package:ezys/providers/session_object.dart';
import 'package:ezys/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WalletService {
  static Future<List<WalletTransactions>> getWalletTransaction() async {
    try {
      var transactionsUrl =
          Uri.parse('${ApiService.url}/getWalletTransactions.php');
      var response = await http
          .post(transactionsUrl, body: {'userId': SessionObject.user.userId});
      return (json.decode(response.body) as List)
          .map((item) => WalletTransactions.fromJson(item))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw "Transaction error";
    }
  }
}
