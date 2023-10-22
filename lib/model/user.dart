class User {
  String? id;
  String? userId;
  String? mobile;
  String? email;
  String? name;
  String? cartId;
  String? status;

  User(
      {this.id,
      this.userId,
      this.mobile,
      this.email,
      this.name,
      this.cartId,
      this.status});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        userId: json['userId'],
        mobile: json['mobile'],
        email: json['email'],
        name: json['name'],
        cartId: json['cartId'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'mobile': mobile,
        'email': email,
        'name': name,
        'cartId': cartId,
        'status': status
      };
}
