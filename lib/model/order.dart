class Order {
  String? id;
  String? orderId;
  String? cartId;
  String? totalAmount;
  String? created;
  String? paymentMethod;
  String? address;
  String? status;
  String? userId;

  Order(
      {this.id,
      this.orderId,
      this.cartId,
      this.totalAmount,
      this.created,
      this.paymentMethod,
      this.address,
      this.status,
      this.userId});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        orderId: json['orderId'],
        cartId: json['cartId'],
        totalAmount: json['totalAmount'],
        created: json['created'],
        paymentMethod: json['paymentMethod'],
        address: json['address'],
        status: json['status'],
        userId: json['userId']);
  }
}
