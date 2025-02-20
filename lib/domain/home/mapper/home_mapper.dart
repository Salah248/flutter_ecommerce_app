import 'package:flutter_ecommerce_app/domain/home/entity/home_entity.dart';

import '../../../data/home/models/home_model.dart';

class ProductMapper {
  static ProductEntity toEntity(ProductModel model) {
    return ProductEntity(
      productId: model.productId,
      createdAt: model.createdAt,
      productName: model.productName,
      price: model.price,
      oldPrice: model.oldPrice,
      sale: model.sale,
      description: model.description,
      category: model.category,
      imageUrl: model.imageUrl,
      favoriteProduct: model.favoriteProduct
          .map((favorite) => FavoriteEntity(
                id: favorite.id,
                forUser: favorite.forUser,
                createdAt: favorite.createdAt,
                forProduct: favorite.forProduct,
                isFavorite: favorite.isFavorite,
              ))
          .toList(),
      purchaseTable: model.purchaseTable
          .map((purchase) => PurchaseEntity(
                id: purchase.id,
                forUser: purchase.forUser,
                isBought: purchase.isBought,
                createdAt: purchase.createdAt,
                forProduct: purchase.forProduct,
              ))
          .toList(),
    );
  }
}
