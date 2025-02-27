import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_circle_indicator.dart';
import 'package:flutter_ecommerce_app/presentaion/main/bloc/cubit/main_data_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/widgets/custom_product_item.dart';


class FavoritesPageView extends StatelessWidget {
  const FavoritesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            const Center(
              child: Text(
                'Your Favorite Products',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            BlocProvider(
              // تمرير isFavoriteView:true حتى لا يتم إصدار حالة ProductDataLoaded
              create: (context) => MainDataCubit()..getProducts(isFavoriteView: true),
              child: BlocConsumer<MainDataCubit, MainDataState>(
                listener: (context, state) {
                  // يمكن إضافة استجابات إضافية للحالات هنا
                },
                builder: (context, state) {
                  if (state is MainDataLoading) {
                    return const CustomCircularIndicator();
                  } else if (state is FavoriteProductLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return CustomProductItem(
                          product: product,
                          isFavorite: context
                              .read<MainDataCubit>()
                              .checkIsFavorite(product.productId!),
                        );
                      },
                    );
                  } else if (state is MainDataError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}