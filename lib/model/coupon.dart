class Coupon {
  String? id;
  String? code;
  String? amount;
  String? minimumAmount;
  String? status;
  String? maxAmount;
  String? count;
  String? userCount;
  String? type;
  String? expiryDate;
  String? description;

  Coupon(
      {this.id,
      this.code,
      this.amount,
      this.minimumAmount,
      this.status,
      this.maxAmount,
      this.count,
      this.userCount,
      this.type,
      this.expiryDate,
      this.description});

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
        id: json['id'],
        code: json['code'],
        amount: json['amount'],
        minimumAmount: json['minimum_amount'],
        status: json['status'],
        maxAmount: json['max_amount'],
        count: json['count'],
        userCount: json['user_count'],
        type: json['type'],
        expiryDate: json['expiryDate'],
        description: json['description']);
  }
}
