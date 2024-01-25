class HomeList {
  String? title;
  String? tag;
  bool isListView;
  bool isVisible;
  List<HomeItem>? items;

  HomeList(
      {this.isListView = false,
      this.isVisible = false,
      this.items,
      this.tag,
      this.title});

  factory HomeList.fromJson(Map<String, dynamic> json) {
    return HomeList(
        title: json['title'],
        tag: json['tag'],
        isListView: json['isList'],
        isVisible: json['isVisible'] ?? true,
        items: (json['items'] != null)
            ? (json['items'] as List)
                .map((item) => HomeItem.fromJson(item))
                .toList()
            : null);
  }
}

class HomeItem {
  String? id;
  String? category;
  String? reference;
  String? imageUrl;
  String? status;

  HomeItem(
      {this.status, this.id, this.category, this.imageUrl, this.reference});

  factory HomeItem.fromJson(Map<String, dynamic> json) {
    return HomeItem(
        id: json['id'],
        category: json['category'],
        imageUrl: json['imageUrl'],
        reference: json['reference'],
        status: json['status']);
  }
}
