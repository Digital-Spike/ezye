import 'dart:convert';

import 'package:ezye/model/wallet.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class WalletService {
  static Future<Wallet> getWalletTransaction(
      {required BuildContext context}) async {
    try {
      var transactionsUrl =
          Uri.parse('${ApiService.url}getWalletTransactions.php');
      var response = await http.post(transactionsUrl, body: {
        'userId': Provider.of<SessionObject>(context, listen: false).user.userId
      });
      return Wallet.fromJson(json.decode(response.body));
    } catch (e) {
      debugPrint(e.toString());
      throw "Transaction error";
    }
  }
}
