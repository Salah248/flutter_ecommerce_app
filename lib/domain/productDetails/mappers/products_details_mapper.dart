import 'package:flutter_ecommerce_app/data/productDetails/model/product_details_model.dart';
import 'package:flutter_ecommerce_app/domain/productDetails/entity/products_details_entity.dart';

class RatesMapper {
  static RatesEntity toEntity(RatesModel model) {
    return RatesEntity(
      id: model.id,
      createdAt: model.createdAt,
      rate: model.rate,
      forUser: model.forUser,
      forProduct: model.forProduct,
    );
  }
}

// Comments_table

class CommentsMapper {
  static CommentsEntity toEntity(CommentsModel comment) {
    return CommentsEntity(
      id: comment.id,
      createdAt: comment.createdAt,
      comment: comment.comment,
      forUser: comment.forUser,
      forProduct: comment.forProduct,
      userName: comment.userName,
      replay: comment.replay,
    );
  }
}
