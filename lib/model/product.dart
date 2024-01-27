class Product {
  String? id;
  String? name;
  String? category;
  String? subCategory;
  String? mrp;
  String? sellingPrice;
  String? productId;
  String? description;
  String? fullDescription;
  String? image1Url;
  String? image2Url;
  String? image3Url;
  String? image4Url;
  String? image5url;
  String? size;
  String? color;
  String? stockStatus;
  String? stockNumber;
  bool isSaved;
  List<ProductVariant>? variant;

  Product(
      {this.id,
      this.name,
      this.category,
      this.description,
      this.fullDescription,
      this.image1Url,
      this.image2Url,
      this.image3Url,
      this.image4Url,
      this.image5url,
      this.mrp,
      this.productId,
      this.sellingPrice,
      this.subCategory,
      this.color,
      this.size,
      this.stockNumber,
      this.stockStatus,
      this.isSaved = false,
      this.variant});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        description: json['description'],
        fullDescription: json['fullDescription'],
        image1Url: json['image1Url'],
        image2Url: json['image2Url'],
        image3Url: json['image3Url'],
        image4Url: json['image4Url'],
        image5url: json['image5url'],
        mrp: json['MRP'],
        productId: json['productId'],
        sellingPrice: json['sellingPrice'],
        subCategory: json['subCategory'],
        color: json['color'],
        size: json['size'],
        stockNumber: json['stock_status'],
        stockStatus: json['stock_number'],
        variant: json['varientDetails'] != null
            ? (json['varientDetails'] as List)
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

  ProductVariant(
      {this.size,
      this.id,
      this.amount,
      this.color,
      this.image,
      this.productId,
      this.stockNumber,
      this.stockStatus,
      this.variantId});

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      productId: json['productId'],
      size: json['size'],
      color: json['color'],
      amount: json['amount'],
      stockStatus: json['stock_status'],
      stockNumber: json['stock_number'],
      variantId: json['varientId'],
      image: json['image'],
    );
  }
}

//productId:ezysp001
