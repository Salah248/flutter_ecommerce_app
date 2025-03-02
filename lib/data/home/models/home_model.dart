class ProductModel {
  final String productId;
  final DateTime createdAt;
  final String productName;
  final String price;
  final String oldPrice;
  final String sale;
  final String description;
  final String category;
  final String imageUrl;
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
    // التحقق من وجود الحقول الأساسية وإلقاء استثناء في حال غيابها
    if (json["product_id"] == null ||
        json["created_at"] == null ||
        json["product_name"] == null ||
        json["price"] == null ||
        json["old_price"] == null ||
        json["sale"] == null ||
        json["description"] == null ||
        json["category"] == null ||
        json["image_url"] == null) {
      throw Exception("Missing required ProductModel field");
    }
    return ProductModel(
      productId: json["product_id"],
      createdAt: DateTime.parse(json["created_at"]),
      productName: json["product_name"],
      price: json["price"],
      oldPrice: json["old_price"],
      sale: json["sale"],
      description: json["description"],
      category: json["category"],
      imageUrl: json["image_url"],
      favoriteProduct: json["favorite_product"] == null
          ? []
          : List<FavoriteProduct>.from(
              json["favorite_product"].map((x) => FavoriteProduct.fromJson(x))),
      purchaseTable: json["purchase_table"] == null
          ? []
          : List<PurchaseTable>.from(
              json["purchase_table"].map((x) => PurchaseTable.fromJson(x))),
    );
  }
}

class FavoriteProduct {
  final String id;
  final String forUser;
  final DateTime createdAt;
  final String forProduct;
  final bool isFavorite;

  FavoriteProduct({
    required this.id,
    required this.forUser,
    required this.createdAt,
    required this.forProduct,
    required this.isFavorite,
  });

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null ||
        json['for_user'] == null ||
        json['created_at'] == null ||
        json['for_product'] == null ||
        json['is_favorite'] == null) {
      throw Exception("Missing required FavoriteProduct field");
    }
    return FavoriteProduct(
      id: json['id'] as String,
      forUser: json['for_user'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      forProduct: json['for_product'] as String,
      isFavorite: json['is_favorite'] as bool,
    );
  }
}

class PurchaseTable {
  final String id;
  final String forUser;
  final bool isBought;
  final DateTime createdAt;
  final String forProduct;

  PurchaseTable({
    required this.id,
    required this.forUser,
    required this.isBought,
    required this.createdAt,
    required this.forProduct,
  });

  factory PurchaseTable.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null ||
        json['for_user'] == null ||
        json['is_bought'] == null ||
        json['created_at'] == null ||
        json['for_product'] == null) {
      throw Exception("Missing required PurchaseTable field");
    }
    return PurchaseTable(
      id: json['id'] as String,
      forUser: json['for_user'] as String,
      isBought: json['is_bought'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      forProduct: json['for_product'] as String,
    );
  }
}
