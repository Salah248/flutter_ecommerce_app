import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/helper/network/failure.dart';
import 'package:flutter_ecommerce_app/core/usecase/base_use_case.dart';
import 'package:flutter_ecommerce_app/data/home/repository/repository.dart';
import 'package:flutter_ecommerce_app/di.dart';
import 'package:flutter_ecommerce_app/domain/home/entity/home_entity.dart';

class GetProductDataUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either<Failure, List<ProductEntity>>> call({params}) async {
    return await di<ProductRepository>().getProductData();
  }
}

class AddPurchaseUseCase extends UseCase<Either<Failure, void>, String> {
  @override
  Future<Either<Failure, void>> call({String? params}) async {
    return await di<ProductRepository>().buyProduct(params!);
  }
}

class GetMyOrdersDataUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either<Failure, List<ProductEntity>>> call({params}) async {
    return await di<ProductRepository>().getMyOrders();
  }
}