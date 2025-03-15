part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError(this.message);
}

final class ProductRateDataLoaded extends ProductDetailsState {

  ProductRateDataLoaded();
}

final class AddOrUpdateRateLoaded extends ProductDetailsState {}

final class AddCommentLoaded extends ProductDetailsState {}

final class CommentDataLoaded extends ProductDetailsState {

}