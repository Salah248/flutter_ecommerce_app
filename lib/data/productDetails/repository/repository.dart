import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/helper/network/failure.dart';
import 'package:flutter_ecommerce_app/domain/productDetails/entity/products_details_entity.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, List<RatesEntity>>> getRatesData(String productId);
  Future<Either<Failure, List<CommentsEntity>>> getCommetntsData(); 

}