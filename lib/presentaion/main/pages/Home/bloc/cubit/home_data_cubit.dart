import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_app/di.dart';
import 'package:flutter_ecommerce_app/domain/home/usecases/get_home_data.dart';
import 'package:meta/meta.dart';

import '../../../../../../domain/home/entity/home_entity.dart';

part 'home_data_state.dart';

class ProductDataCubit extends Cubit<ProductDataState> {
  ProductDataCubit() : super(ProductDataLoading());

  Future<void> getProducts() async {
    emit(ProductDataLoading()); // إظهار حالة التحميل
    var returnData = await di<GetProductDataUseCase>().call();
    returnData.fold(
      (error) {
        log(error.message);
        emit(ProductDataError(error.message)); // إظهار حالة الخطأ
      },
      (data) {
        log(data.toString());
        emit(ProductDataLoaded(data)); // إظهار البيانات المحملة
      },
    );
  }
}