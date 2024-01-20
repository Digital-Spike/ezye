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
  String? couponCode;
  String? couponAmount;
  String? finalAmount;
  String? ezyeCoins;
  List<OrderItem>? productDetails;

  Order(
      {this.id,
      this.orderId,
      this.cartId,
      this.totalAmount,
      this.created,
      this.paymentMethod,
      this.address,
      this.status,
      this.userId,
      this.couponCode,
      this.couponAmount,
      this.ezyeCoins,
      this.finalAmount,
      this.productDetails});

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
      userId: json['userId'],
      couponCode: json['couponCode'],
      couponAmount: json['couponAmount'],
      productDetails: (json['productDetails'] as List).map((item) {
        return OrderItem.fromJson(item);
      }).toList(),
      ezyeCoins: json['ezyeCoins'],
      finalAmount: json['finalAmount'],
    );
  }
}

class OrderItem {
  String? id;
  String? userId;
  String? productId;
  String? productName;
  String? size;
  String? color;
  String? quantity;
  String? amount;
  String? cartId;
  String? status;

  OrderItem(
      {this.id,
      this.userId,
      this.productId,
      this.productName,
      this.size,
      this.color,
      this.quantity,
      this.amount,
      this.cartId,
      this.status});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        id: json['id'],
        userId: json['userId'],
        productId: json['productId'],
        productName: json['productName'],
        size: json['size'],
        color: json['color'],
        quantity: json['quantity'],
        amount: json['amount'],
        cartId: json['cartId'],
        status: json['status']);
  }
}
