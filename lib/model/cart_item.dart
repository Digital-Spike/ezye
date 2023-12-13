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
      this.userId});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['id'],
        userId: json['userId'],
        productId: json['productId'],
        name: json['productName'],
        size: json['size'],
        color: json['color'],
        quantity: json['quantity'],
        mrp: json['amount'],
        cartId: json['cartId'],
        status: json['status']);
  }
}
