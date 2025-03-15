import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/widgets/app_bar.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_circle_indicator.dart';
import 'package:flutter_ecommerce_app/presentaion/main/bloc/cubit/main_data_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/widgets/custom_product_item.dart';

import '../../../../../../core/resources/app_colors.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        hideBack: false,
        backgroundColor: AppColors.kPrimaryColor,
        title: Text(
          'My Orders',
          style: TextStyle(color: AppColors.kWhiteColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocProvider(
            // تمرير isMyOrdersView:true حتى لا يتم إصدار حالة ProductDataLoaded
            create: (context) =>
                MainDataCubit()..getProducts(isMyOrdersView: true),
            child: BlocConsumer<MainDataCubit, MainDataState>(
              listener: (context, state) {
                // يمكن إضافة استجابات إضافية للحالات هنا
              },
              builder: (context, state) {
                if (state is MainDataLoading) {
                  return const CustomCircularIndicator();
                } else if (state is MyOrdersLoaded) {
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
        ),
      ),
    );
  }
}
