import 'dart:convert';

import 'package:ezye/model/transaction.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
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
