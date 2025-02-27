import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/helper/network/failure.dart';
import 'package:flutter_ecommerce_app/core/usecase/base_use_case.dart';
import 'package:flutter_ecommerce_app/data/productDetails/repository/repository.dart';
import 'package:flutter_ecommerce_app/di.dart';
import 'package:flutter_ecommerce_app/domain/productDetails/entity/products_details_entity.dart';

class GetRatesDataUseCase extends UseCase<Either, String> {
  @override
  Future<Either<Failure, List<RatesEntity>>> call({String? params}) async {
    return await di<ProductDetailsRepository>().getRatesData(params ?? 'error in product Id');
  }
}

class GetCommentsDataUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either<Failure, List<CommentsEntity>>> call({params}) async {
    return await di<ProductDetailsRepository>().getCommetntsData();
  }
}
