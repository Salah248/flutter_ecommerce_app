class ProductModel {
  final String? productId;
  final DateTime? createdAt;
  final String? productName;
  final String? price;
  final String? oldPrice;
  final String? sale;
  final String? description;
  final String? category;
  final String? imageUrl;
  final List<FavoriteProduct> favoriteProduct;
  final List<PurchaseTable> purchaseTable;

  ProductModel({
    required this.productId,
    required this.createdAt,
    required this.productName,
    required this.price,
    required this.oldPrice,
    required this.sale,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.favoriteProduct,
    required this.purchaseTable,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json["product_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      productName: json["product_name"],
      price: json["price"],
      oldPrice: json["old_price"],
      sale: json["sale"],
      description: json["description"],
      category: json["category"],
      imageUrl: json["image_url"],
      favoriteProduct: json["favorite_product"] == null
          ? []
          : List<FavoriteProduct>.from(json["favorite_product"]!
              .map((x) => FavoriteProduct.fromJson(x))),
      purchaseTable: json["purchase_table"] == null
          ? []
          : List<PurchaseTable>.from(json["purchase_table"]!
              .map((x) => PurchaseTable.fromJson(x))),
    );
  }
}

class FavoriteProduct {
  String? id;
  String? forUser;
  DateTime? createdAt;
  String? forProduct;
  bool? isFavorite;

  FavoriteProduct({
    this.id,
    this.forUser,
    this.createdAt,
    this.forProduct,
    this.isFavorite,
  });

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    return FavoriteProduct(
      id: json['id'] as String?,
      forUser: json['for_user'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      forProduct: json['for_product'] as String?,
      isFavorite: json['is_favorite'] as bool?,
    );
  }
}

class PurchaseTable {
  String? id;
  String? forUser;
  bool? isBought;
  DateTime? createdAt;
  String? forProduct;

  PurchaseTable({
    this.id,
    this.forUser,
    this.isBought,
    this.createdAt,
    this.forProduct,
  });

  factory PurchaseTable.fromJson(Map<String, dynamic> json) => PurchaseTable(
        id: json['id'] as String?,
        forUser: json['for_user'] as String?,
        isBought: json['is_bought'] as bool?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        forProduct: json['for_product'] as String?,
      );
}
