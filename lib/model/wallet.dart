import 'package:ezye/model/transaction.dart';

class Wallet {
  String? totalEarnings;
  String? totalSpent;
  List<WalletTransactions>? walletTransactions;

  Wallet({this.totalEarnings, this.totalSpent, this.walletTransactions});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      totalEarnings: json['earnings'],
      totalSpent: json['spent'],
      walletTransactions: (json['transactions'] as List)
          .map((item) => WalletTransactions.fromJson(item))
          .toList(),
    );
  }
}
