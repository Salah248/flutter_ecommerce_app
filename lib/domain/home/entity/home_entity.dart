
class ProductEntity {
    ProductEntity({
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

    final String? productId;
    final DateTime? createdAt;
    final String? productName;
    final String? price;
    final String? oldPrice;
    final String? sale;
    final String? description;
    final String? category;
    final String? imageUrl;
    final List<FavoriteEntity> favoriteProduct;
    final List<PurchaseEntity> purchaseTable;

}

class FavoriteEntity {
  String? id;
  String? forUser;
  DateTime? createdAt;
  String? forProduct;
  bool? isFavorite;

  FavoriteEntity({
    this.id,
    this.forUser,
    this.createdAt,
    this.forProduct,
    this.isFavorite,
  });



}
class PurchaseEntity {
  String? id;
  String? forUser;
  bool? isBought;
  DateTime? createdAt;
  String? forProduct;

  PurchaseEntity({
    this.id,
    this.forUser,
    this.isBought,
    this.createdAt,
    this.forProduct,
  });
}
