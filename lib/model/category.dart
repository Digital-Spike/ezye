class Category {
  String? id;
  String? name;
  String? imageUrl;
  String? reference;

  Category({this.imageUrl, this.id, this.name, this.reference});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      reference: json['reference'],
    );
  }
}
