import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ecommerce_app/constants.dart';
import 'package:flutter_ecommerce_app/core/helper/network/dio_clinet.dart';
import 'package:flutter_ecommerce_app/di.dart';
import 'package:flutter_ecommerce_app/domain/productDetails/entity/products_details_entity.dart';
import 'package:flutter_ecommerce_app/domain/productDetails/usecase/product_details_usecase.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  String userId = Supabase.instance.client.auth.currentUser!.id;

  List<RatesEntity> rates = [];
  int averageRate = 0;
  int userRate = 5;
  List<CommentsEntity> comments = [];

  Future<void> getRates({required String productId}) async {
    emit(ProductDetailsLoading());
    try {
      rates.clear();
      averageRate = 0;
      Response response = await di<DioClient>()
          .get("rates_table?select=*&for_product=eq.$productId");
      for (var rate in response.data) {
        rates.add(RatesEntity.fromJson(rate));
      }
      _getAverageRate();
      _getUserRate();
      emit(ProductRateDataLoaded());
    } catch (e) {
      log(e.toString());
      emit(ProductDetailsError(e.toString()));
    }
  }

  Future<void> addOrUpdateUserRate({
    required String productId,
    required Map<String, dynamic> data,
  }) async {
    String path =
        "rates_table?select=*&for_user=eq.$userId&for_product=eq.$productId";
    emit(ProductDetailsLoading());
    try {
      if (_isUserRateExist(productId: productId)) {
        await di<DioClient>().patch(path, data: data);
      } else {
        await di<DioClient>().post(path, data: data);
      }
      emit(AddOrUpdateRateLoaded());
    } catch (e) {
      log(e.toString());
      emit(ProductDetailsError(e.toString()));
    }
  }

  void _getUserRate() {
    List<RatesEntity> userRates = rates.where((rate) {
      return rate.forUser == userId;
    }).toList();
    if (userRates.isNotEmpty) {
      userRate = userRates[0].rate!;
    }
  }

  void _getAverageRate() {
    if (rates.isEmpty) {
      averageRate = 0;
      return;
    }


    for (var userRate in rates) {
       if (userRate.rate != null) {
        //[4,2,1,5,3]
        averageRate += userRate.rate!; //15
      }
    }
    if (rates.isNotEmpty) {
      averageRate = averageRate ~/ rates.length;
    }
  }

  bool _isUserRateExist({required String productId}) {
    for (var rate in rates) {
      if ((rate.forUser == userId) && (rate.forProduct == productId)) {
        return true;
      }
    }
    return false;
  }

  Future<void> addComment({required Map<String, dynamic> data}) async {
    emit(ProductDetailsLoading());
    try {
      await di<DioClient>().post(commentUrl, data: data);
      await getComment(); // إعادة جلب التعليقات بعد الإضافة
      emit(AddCommentLoaded());
    } catch (e) {
      log(e.toString());
      emit(ProductDetailsError(e.toString()));
    }
  }

  Future<void> getComment() async {
    emit(ProductDetailsLoading());
    var returnData = await di<GetCommentsDataUseCase>().call();
    returnData.fold(
      (error) {
        log(error.message);
        emit(ProductDetailsError(error.message));
      },
      (data) {
        comments = data; // تحديث القائمة بالبيانات الجديدة
        log(comments.toString());
        emit(CommentDataLoaded());
      },
    );
  }
}
