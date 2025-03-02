import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/helper/network/network_info.dart';
import 'package:flutter_ecommerce_app/data/home/models/home_model.dart';
import 'package:flutter_ecommerce_app/data/home/repository/repository.dart';
import 'package:flutter_ecommerce_app/data/home/sources/home_services.dart';
import 'package:flutter_ecommerce_app/di.dart';
import 'package:flutter_ecommerce_app/domain/home/entity/home_entity.dart';
import 'package:flutter_ecommerce_app/domain/home/mapper/home_mapper.dart';

import '../../../core/helper/network/error_handler.dart';
import '../../../core/helper/network/failure.dart';

class ProductRepositoryImpl implements ProductRepository {
  final NetworkInfo _networkInfo;

  ProductRepositoryImpl(this._networkInfo);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductData() async {
    if (await _networkInfo.isConnected) {
      try {
        var result = await di<HomeServices>().getHomeData();
        return result.fold(
          (error) => Left(Failure(0, error)),
          (data) {
            // تأكد من أن البيانات قائمة
            if (data is List) {
              var products = data
                  .map((item) =>
                      ProductMapper.toEntity(ProductModel.fromJson(item)))
                  .toList();
              return Right(products);
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
  Future<Either<Failure, void>> buyProduct(String productId) async {
    if (productId.isEmpty) {
      return Left(Failure(0, "Product ID cannot be empty"));
    }

    if (await _networkInfo.isConnected) {
      try {
        var result = await di<HomeServices>().buyProduct(productId);
        return result.fold(
          (error) => Left(Failure(0, error)),
          (_) =>
              const Right(null), // إرجاع Right(null) لأن النوع المتوقع هو void
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
  Future<Either<Failure, List<ProductEntity>>> getMyOrders() async {
    if (await _networkInfo.isConnected) {
      try {
        var result = await di<HomeServices>().getHomeData();
        return result.fold(
          (error) => Left(Failure(0, error)),
          (data) {
            // تأكد من أن البيانات قائمة
            if (data is List) {
              var products = data
                  .map((item) =>
                      ProductMapper.toEntity(ProductModel.fromJson(item)))
                  .toList();
              final myOrdersProducts = products
                  .where((product) => product.purchaseTable
                      .any((order) => order.isBought == true))
                  .toList();
              return Right(myOrdersProducts);
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
