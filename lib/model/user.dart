class UserModel {
  String? id;
  String? userId;
  String? mobile;
  String? email;
  String? name;
  String? cartId;
  String? status;
  String? image;
  String? subscriptionId;
  String? walletBalance;
  String? cartItemCount;

  UserModel(
      {this.id,
      this.userId,
      this.mobile,
      this.email,
      this.name,
      this.cartId,
      this.status,
      this.image,
      this.subscriptionId,
      this.walletBalance,
      this.cartItemCount});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        userId: json['userId'],
        mobile: json['mobile'],
        email: json['email'],
        name: json['name'],
        cartId: json['cartId'],
        status: json['status'],
        image: json['image'],
        walletBalance: json['wallet_balance'],
        subscriptionId: json['subscriptionId'],
        cartItemCount: json['cartItemCount']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'mobile': mobile,
        'email': email,
        'name': name,
        'cartId': cartId,
        'status': status,
        'image': image,
        'wallet_balance': walletBalance,
        'subscriptionId': subscriptionId,
        'cartItemCount': cartItemCount
      };
}
