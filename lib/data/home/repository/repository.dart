import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/home/entity/home_entity.dart';

import '../../../core/helper/network/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProductData();
  Future<Either<Failure, void>> buyProduct(String productId);
  Future<Either<Failure, List<ProductEntity>>> getMyOrders();
}
