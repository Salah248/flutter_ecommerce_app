import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/widgets/app_bar.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_circle_indicator.dart';
import 'package:flutter_ecommerce_app/presentaion/main/bloc/cubit/main_data_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/widgets/custom_product_item.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainDataCubit()..filterProductsByCategory(category),
      child: Scaffold(
        appBar: const BasicAppbar(
          hideBack: false,
          backgroundColor: AppColors.kPrimaryColor,
          title: Text(
            'Category Results',
            style: TextStyle(color: AppColors.kWhiteColor),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocConsumer<MainDataCubit, MainDataState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is CategoryProductLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.product.length,
                    itemBuilder: (context, index) {
                      final product = state.product[index];
                      return CustomProductItem(
                        product: product, isFavorite: context
                              .read<MainDataCubit>()
                              .checkIsFavorite(state.product[index].productId!),
                      );
                    },
                  );
                } else if (state is MainDataLoading) {
                  return const Center(child: CustomCircularIndicator());
                } else {
                  return const Center(child: Text('No products found'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}