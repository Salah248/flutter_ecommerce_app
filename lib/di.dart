import 'package:flutter_ecommerce_app/core/helper/network/dio_clinet.dart';
import 'package:flutter_ecommerce_app/core/helper/network/network_info.dart';
import 'package:flutter_ecommerce_app/data/home/repository/repository.dart';
import 'package:flutter_ecommerce_app/data/home/sources/home_services.dart';
import 'package:flutter_ecommerce_app/domain/home/repository/repository_impl.dart';
import 'package:flutter_ecommerce_app/domain/home/usecases/get_home_data.dart';
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

  // Repositories
  di.registerSingleton<ProductRepository>(
      ProductRepositoryImpl(di<NetworkInfo>()));

  // Use Cases
  di.registerSingleton<GetProductDataUseCase>(GetProductDataUseCase());
}
