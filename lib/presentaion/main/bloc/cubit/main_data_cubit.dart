import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecommerce_app/constants.dart';
import 'package:flutter_ecommerce_app/core/helper/network/dio_clinet.dart';
import 'package:flutter_ecommerce_app/di.dart';
import 'package:flutter_ecommerce_app/domain/home/usecases/get_home_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../domain/home/entity/home_entity.dart';

part 'main_data_state.dart';

class MainDataCubit extends Cubit<MainDataState> {
  MainDataCubit() : super(MainDataLoading());

  final String userId = Supabase.instance.client.auth.currentUser!.id;

  // Lists to store products and favorite products
  List<ProductEntity> products = [];
  List<ProductEntity> favoriteProductList = [];
  Map<String, bool> favoriteProducts = {};

  // Fetch products based on query, category, or view type (favorites or orders)
  Future<void> getProducts({
    String? query,
    String? category,
    bool isFavoriteView = false,
    bool isMyOrdersView = false,
  }) async {
    // Reset lists
    products = [];
    favoriteProductList = [];
    favoriteProducts.clear();

    emit(MainDataLoading());
    var returnData = await di<GetProductDataUseCase>().call();
    returnData.fold(
      (error) {
        log(error.message);
        emit(MainDataError(error.message));
      },
      (data) {
        log(data.toString());

        // Update products list
        products = data;

        // Update favorite products list
        getProductsByFavorite();

        // If it's the orders view, fetch orders
        if (isMyOrdersView) {
          getMyOrdersProduct();
        }

        // Check for search query
        if (query != null && query.isNotEmpty) {
          search(query);
        }
        // Check for category filter
        else if (category != null && category.isNotEmpty) {
          filterProductsByCategory(category);
        }
        // If no query or category, show all products
        else {
          if (!isFavoriteView && !isMyOrdersView) {
            emit(ProductDataLoaded(data));
          }
        }
      },
    );
  }

  // Search for products by query
  void search(String query) {
    searchProduct(query);
    emit(MainDataLoading());
  }

  // Perform the search operation
  void searchProduct(String query) async {
    var returnedData = await di<GetProductDataUseCase>().call(params: query);
    returnedData.fold(
      (error) {
        emit(MainDataError(error.message));
      },
      (data) {
        final filteredProducts = data
            .where((product) =>
                product.productName
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ??
                false)
            .toList();

        if (filteredProducts.isEmpty) {
          emit(MainDataError('No products found for "$query"'));
        } else {
          emit(SearchProductLoaded(filteredProducts));
        }
      },
    );
  }

  // Filter products by category
  void filterProductsByCategory(String category) async {
    emit(MainDataLoading());
    var returnedData = await di<GetProductDataUseCase>().call();
    returnedData.fold(
      (error) {
        emit(MainDataError(error.message));
      },
      (data) {
        final filteredProducts = data
            .where((product) =>
                product.category?.toLowerCase() == category.toLowerCase())
            .toList();

        if (filteredProducts.isEmpty) {
          emit(MainDataError('No products found in category "$category"'));
        } else {
          emit(CategoryProductLoaded(filteredProducts));
        }
      },
    );
  }

  // Add a product to favorites
  Future<void> addToFavorite(String productId) async {
    emit(MainDataLoading());
    try {
      await di<DioClient>().post(favoriteUrl, data: {
        "is_favorite": true,
        "for_user": userId,
        "for_product": productId,
      });
      favoriteProducts[productId] = true;
      emit(SuccessAddToFavorite());
      await getProducts();
    } catch (e) {
      log(e.toString());
      emit(MainDataError(e.toString()));
    }
  }

  // Remove a product from favorites
  Future<void> removeFromFavorite(String productId) async {
    emit(MainDataLoading());
    try {
      await di<DioClient>()
          .delete("$favoriteUrl?for_user=eq.$userId&for_product=eq.$productId");
      favoriteProducts.remove(productId);
      emit(SuccessRemoveFromFavorite());
      await getProducts(isFavoriteView: true);
    } catch (e) {
      log(e.toString());
      emit(MainDataError(e.toString()));
    }
  }

  // Check if a product is in favorites
  bool checkIsFavorite(String productId) {
    return favoriteProducts.containsKey(productId);
  }

  // Filter and update the favorite products list
  void getProductsByFavorite() {
    // Clear the list before filtering
    favoriteProductList.clear();

    for (var product in products) {
      if (product.favoriteProduct.isNotEmpty) {
        for (var favorite in product.favoriteProduct) {
          if (favorite.forUser == userId) {
            if (!favoriteProductList.contains(product)) {
              favoriteProductList.add(product);
            }
            favoriteProducts[product.productId!] = true;
          }
        }
      }
    }
    emit(FavoriteProductLoaded(favoriteProductList));
  }

  // Buy a product
  Future<void> buyProduct(String productId) async {
    emit(MainDataLoading());
    try {
      var returnedData = await di<AddPurchaseUseCase>().call(params: productId);
      return returnedData.fold(
        (l) {
          emit(MainDataError(l.message));
        },
        (_) {
          emit(SuccessBuyProduct());
        },
      );
    } catch (e) {
      log(e.toString());
      emit(MainDataError(e.toString()));
    }
  }

  // Fetch and filter products for "My Orders" view
  Future<void> getMyOrdersProduct() async {
    emit(MainDataLoading());
    try {
      var returnedData = await di<GetMyOrdersDataUseCase>().call();
      return returnedData.fold(
        (l) {
          emit(MainDataError(l.message));
        },
        (data) {
          emit(MyOrdersLoaded(data));
        },
      );
    } catch (e) {
      log(e.toString());
      emit(MainDataError(e.toString()));
    }
  }
}