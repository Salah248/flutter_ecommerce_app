part of 'main_data_cubit.dart';

@immutable
abstract class MainDataState {}

class MainDataInitial extends MainDataState {}

class MainDataLoading extends MainDataState {}

class MainDataError extends MainDataState {
  final String message;
  MainDataError(this.message);
}

class ProductDataLoaded extends MainDataState {
  final List<ProductEntity> product;
  ProductDataLoaded(this.product);
}

final class SearchProductLoaded extends MainDataState {
  final List<ProductEntity> product;
  SearchProductLoaded(this.product);
}

final class CategoryProductLoaded extends MainDataState {
  final List<ProductEntity> product;
  CategoryProductLoaded(this.product);
}

final class FavoriteProductLoaded extends MainDataState {
  final List<ProductEntity> products;
  FavoriteProductLoaded(this.products);
}

final class SuccessAddToFavorite extends MainDataState {}

final class SuccessRemoveFromFavorite extends MainDataState {}

final class SuccessBuyProduct extends MainDataState {}

final class MyOrdersLoaded extends MainDataState {
  final List<ProductEntity> products;
  MyOrdersLoaded(this.products);
}