import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_app/constants.dart';
import 'package:flutter_ecommerce_app/core/helper/network/dio_clinet.dart';
import 'package:flutter_ecommerce_app/di.dart';

abstract class ProductsDetailsServices {
  Future<Either<String, dynamic>> getRatesData(String productId); 
  Future<Either<String, dynamic>> getCommetntsData(); 
  
}

class ProductsDetailesServicesImpl extends ProductsDetailsServices {
  @override
  Future<Either<String, dynamic>> getRatesData(String productId) async {
    try {
      var response = await di<DioClient>().get('$ratesUrl$productId');
      log(response.data.toString()); // تأكد من أن البيانات قائمة
      return Right(response.data);
    } on DioException catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['message'] != null) {
        log(e.response!.data['message']);
        return Left(e.response!.data['message']);
      } else {
        return const Left("An error occurred");
      }
    }
  }
  
  @override
  Future<Either<String, dynamic>> getCommetntsData() async{
    try {
      var response = await di<DioClient>().get(commentUrl);
      log(response.data.toString()); // تأكد من أن البيانات قائمة
      return Right(response.data);
    } on DioException catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['message'] != null) {
        log(e.response!.data['message']);
        return Left(e.response!.data['message']);
      } else {
        return const Left("An error occurred");
      }
    }
  }
}