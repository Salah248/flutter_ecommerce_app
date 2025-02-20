part of 'home_data_cubit.dart';

@immutable
abstract class ProductDataState {}

class ProductDataInitial extends ProductDataState {}

class ProductDataLoading extends ProductDataState {}

class ProductDataLoaded extends ProductDataState {
  final List<ProductEntity> product;
  ProductDataLoaded(this.product);
}

class ProductDataError extends ProductDataState {
  final String message;
  ProductDataError(this.message);
}