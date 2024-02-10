class CartItem {
  String? id;
  String? userId;
  String? productId;
  String? name;
  String? size;
  String? color;
  String? quantity;
  String? mrp;
  String? cartId;
  String? status;
  String? variantId;
  String? discount;
  String? amount;

  CartItem(
      {this.size,
      this.productId,
      this.color,
      this.id,
      this.mrp,
      this.cartId,
      this.name,
      this.quantity,
      this.status,
      this.userId,
      this.variantId,
      this.discount,
      this.amount});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['id'],
        userId: json['userId'],
        productId: json['productId'],
        name: json['productName'],
        size: json['size'],
        color: json['color'],
        quantity: json['quantity'],
        mrp: json['mrp'],
        cartId: json['cartId'],
        status: json['status'],
        variantId: json['varientId'],
        discount: json['discount'],
        amount: json['amount']);
  }
}
