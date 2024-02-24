class Product {
  String? id;
  String? name;
  String? category;
  String? subCategory;
  String? productId;
  String? description;
  String? fullDescription;
  String? createAt;
  String? tags;
  bool isSaved;
  List<ProductVariant>? variant;

  Product(
      {this.id,
      this.name,
      this.category,
      this.description,
      this.fullDescription,
      this.productId,
      this.subCategory,
      this.createAt,
      this.tags,
      this.variant,
      this.isSaved = false});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        description: json['description'],
        fullDescription: json['fullDescription'],
        productId: json['productId'],
        subCategory: json['subCategory'],
        createAt: json['product_created'],
        tags: json['tags'],
        variant: json['varients'] != null
            ? (json['varients'] as List)
                .map((variant) => ProductVariant.fromJson(variant))
                .toList()
            : null);
  }
}

class ProductVariant {
  String? id;
  String? productId;
  String? size;
  String? color;
  String? amount;
  String? stockStatus;
  String? stockNumber;
  String? variantId;
  String? image;
  String? mrp;
  String? sellingPrice;
  String? discount;
  String? variantCreated;

  ProductVariant(
      {this.id,
      this.amount,
      this.color,
      this.image,
      this.productId,
      this.stockNumber,
      this.stockStatus,
      this.variantId,
      this.discount,
      this.mrp,
      this.size,
      this.sellingPrice,
      this.variantCreated});

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      productId: json['productId'],
      color: json['color'],
      amount: json['amount'],
      stockStatus: json['stock_status'],
      stockNumber: json['stock_number'],
      variantId: json['varientId'],
      image: json['image'],
      discount: json['discount'],
      mrp: json['mrp'],
      size: json['size'],
      sellingPrice: json['sellingPrice'],
      variantCreated: json['varient_created'],
    );
  }
}
