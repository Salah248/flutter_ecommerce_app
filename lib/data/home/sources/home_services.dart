import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_app/constants.dart';
import 'package:flutter_ecommerce_app/core/helper/network/dio_clinet.dart';
import 'package:flutter_ecommerce_app/di.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HomeServices {
  Future<Either<String, dynamic>> getHomeData();
  Future<Either<String, void>> buyProduct(String productId);
}

class HomeServicesImpl extends HomeServices {
  @override
  Future<Either<String, dynamic>> getHomeData() async {
    try {
      var response = await di<DioClient>().get(productUrl);
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
  Future<Either<String, void>> buyProduct(String productId) async {
    try {
      await di<DioClient>().post(purchaseUrl, data: {
        "is_bought": true,
        "for_user": di<Supabase>().client.auth.currentUser!.id,
        "for_product": productId,
      });
      return const Right(null); // إرجاع Right(null) لأن النوع المتوقع هو void
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