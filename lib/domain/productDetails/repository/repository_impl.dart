import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/helper/network/failure.dart';
import 'package:flutter_ecommerce_app/core/helper/network/network_info.dart';
import 'package:flutter_ecommerce_app/data/productDetails/model/product_details_model.dart';
import 'package:flutter_ecommerce_app/data/productDetails/repository/repository.dart';
import 'package:flutter_ecommerce_app/data/productDetails/sources/product_details_services.dart';
import 'package:flutter_ecommerce_app/di.dart';
import 'package:flutter_ecommerce_app/domain/productDetails/entity/products_details_entity.dart';
import 'package:flutter_ecommerce_app/domain/productDetails/mappers/products_details_mapper.dart';

import '../../../core/helper/network/error_handler.dart';

class ProductDetailsRepositoryImpl extends ProductDetailsRepository {
  final NetworkInfo _networkInfo;
  ProductDetailsRepositoryImpl(this._networkInfo);
  @override
  Future<Either<Failure, List<RatesEntity>>> getRatesData(
      String productId) async {
    if (await _networkInfo.isConnected) {
      try {
        var result =
            await di<ProductsDetailsServices>().getRatesData(productId);
        return result.fold(
          (error) => Left(Failure(0, error)),
          (data) {
            // تأكد من أن البيانات قائمة
            if (data is List) {
              var rates = data
                  .map(
                      (item) => RatesMapper.toEntity(RatesModel.fromJson(item)))
                  .toList();
              return Right(rates);
            } else {
              return Left(Failure(0, "Invalid data format"));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<CommentsEntity>>> getCommetntsData() async {
    if (await _networkInfo.isConnected) {
      try {
        var result = await di<ProductsDetailsServices>().getCommetntsData();
        return result.fold(
          (error) => Left(Failure(0, error)),
          (data) {
            // تأكد من أن البيانات قائمة
            if (data is List) {
              var comments = data
                  .map((item) =>
                      CommentsMapper.toEntity(CommentsModel.fromJson(item)))
                  .toList();
              return Right(comments);
            } else {
              return Left(Failure(0, "Invalid data format"));
            }
          },
        );
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
