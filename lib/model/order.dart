import 'package:ezye/model/cart_item.dart';

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
  List<CartItem>? items;
  String? deliveryCharge;

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
      this.items,
      this.deliveryCharge});

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
        couponAmount: json['couponAmount'] ?? '0',
        items: (json['productDetails'] != null)
            ? (json['productDetails'] as List).map((item) {
                return CartItem.fromJson(item);
              }).toList()
            : [],
        ezyeCoins: json['ezyeCoins'],
        finalAmount: json['finalAmount'],
        deliveryCharge: json['deliveryCharge'] ?? '50');
  }
}
