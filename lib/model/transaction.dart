class WalletTransactions {
  String? id;
  String? userId;
  String? created;
  String? amount;
  String? status;
  String? reference;
  String? source;

  WalletTransactions(
      {this.userId,
      this.status,
      this.amount,
      this.id,
      this.created,
      this.reference,
      this.source});

  factory WalletTransactions.fromJson(Map<String, dynamic> json) {
    return WalletTransactions(
        userId: json['userId'],
        status: json['status'],
        amount: json['amount'],
        id: json['id'],
        created: json['created'],
        reference: json['reference'],
        source: json['source']);
  }
}
