import 'package:flutter_ecommerce_app/core/helper/network/dio_clinet.dart';
import 'package:flutter_ecommerce_app/core/helper/network/network_info.dart';
import 'package:flutter_ecommerce_app/data/home/repository/repository.dart';
import 'package:flutter_ecommerce_app/data/home/sources/home_services.dart';
import 'package:flutter_ecommerce_app/data/productDetails/repository/repository.dart';
import 'package:flutter_ecommerce_app/data/productDetails/sources/product_details_services.dart';
import 'package:flutter_ecommerce_app/domain/home/repository/repository_impl.dart';
import 'package:flutter_ecommerce_app/domain/home/usecases/get_home_data.dart';
import 'package:flutter_ecommerce_app/domain/productDetails/repository/repository_impl.dart';
import 'package:flutter_ecommerce_app/domain/productDetails/usecase/product_details_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final di = GetIt.instance;

void setUpDi() {
  // DioClient
  di.registerSingleton<DioClient>(DioClient());

  // NetworkInfo
  di.registerSingleton<NetworkInfo>(
    NetworkInfoImpl(InternetConnectionChecker.createInstance()),
  );

  // Services
  di.registerSingleton<HomeServices>(HomeServicesImpl());
  di.registerSingleton<ProductsDetailsServices>(ProductsDetailesServicesImpl());

  // Repositories
  di.registerSingleton<ProductRepository>(
      ProductRepositoryImpl(di<NetworkInfo>()));
  di.registerSingleton<ProductDetailsRepository>(ProductDetailsRepositoryImpl(di<NetworkInfo>()));

  // Use Cases
  di.registerSingleton<GetProductDataUseCase>(GetProductDataUseCase());
  di.registerSingleton<GetRatesDataUseCase>(GetRatesDataUseCase());
  di.registerSingleton<GetCommentsDataUseCase>(GetCommentsDataUseCase());
}
