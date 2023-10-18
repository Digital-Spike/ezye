class Address {
  String? id;
  String? userId;
  String? line1;
  String? line2;
  String? city;
  String? pinCode;
  String? type;
  String? status;

  Address(
      {this.line1,
      this.id,
      this.userId,
      this.line2,
      this.status,
      this.city,
      this.pinCode,
      this.type});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      userId: json['userId'],
      line1: json['line1'],
      line2: json['line2'],
      status: json['status'],
      city: json['city'],
      pinCode: json['pincode'],
      type: json['type'],
    );
  }
}
