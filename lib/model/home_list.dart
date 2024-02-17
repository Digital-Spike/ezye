class HomeList {
  String? bannerId;
  String? bannerName;
  String? bannerStyle;
  String? created;
  List<HomeItem>? items;

  HomeList({
    this.bannerId,
    this.bannerName,
    this.bannerStyle,
    this.created,
    this.items,
  });

  factory HomeList.fromJson(Map<String, dynamic> json) {
    return HomeList(
        bannerId: json['bannerId'],
        bannerName: json['bannerName'],
        bannerStyle: json['bannerStyle'],
        created: json['created'],
        items: json['items'] != null
            ? (json['items'] as List)
                .map((variant) => HomeItem.fromJson(variant))
                .toList()
            : null);
  }
}

class HomeItem {
  String? bannerItemsId;
  String? bannerId;
  String? title;
  String? imageUrl;
  String? tags;

  HomeItem({
    this.title,
    this.bannerItemsId,
    this.bannerId,
    this.imageUrl,
    this.tags,
  });

  factory HomeItem.fromJson(Map<String, dynamic> json) {
    return HomeItem(
      bannerItemsId: json['bannerItemsId'],
      bannerId: json['bannerId'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      tags: json['tags'],
    );
  }
}
