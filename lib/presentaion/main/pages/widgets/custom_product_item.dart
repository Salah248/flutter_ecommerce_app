import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/function/show_msg_snack.dart';
import 'package:flutter_ecommerce_app/core/helper/navigation/app_navigation.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_elevated_button.dart';
import 'package:flutter_ecommerce_app/domain/home/entity/home_entity.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/Product_details/product_details_view.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/widgets/custom_cached_image.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

import '../../bloc/cubit/main_data_cubit.dart';

class CustomProductItem extends StatelessWidget {
  const CustomProductItem({
    super.key,
    required this.product,
    required this.isFavorite,
  });
  final ProductEntity product;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    var mainCubit = context.read<MainDataCubit>();

    return GestureDetector(
      onTap: () => AppNavigator.push(
          context,
          ProductDetailsView(
            product: product,
            isFavorite: isFavorite,
          )),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: CachedImage(
                    imageUrl: product.imageUrl ??
                        "https://img.freepik.com/premium-vector/404-tab-red_114341-29.jpg?w=826",
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      '${product.sale}% OFF',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.productName ?? 'Product name',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  BlocBuilder<MainDataCubit, MainDataState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          if (isFavorite) {
                            mainCubit.removeFromFavorite(product.productId!);
                          } else {
                            mainCubit.addToFavorite(product.productId!);
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: isFavorite
                              ? AppColors.kPrimaryColor
                              : AppColors.kGreyColor,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${product.price} LE'),
                      Text(
                        '${product.oldPrice} LE',
                        style: const TextStyle(
                          color: AppColors.kGreyColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentView(
                            onPaymentSuccess: () {
                              mainCubit.buyProduct(product.productId!);
                              showMsgSnackBar(context, 'payment success, check your orders');
                              // Handle payment success
                              log('Payment Success');
                            },
                            onPaymentError: () {
                              // Handle payment failure
                              log('Payment Error');
                            },
                            price: double.parse(
                              product.price ?? '100',
                            ), // Required: Total price (e.g., 100 for 100 EGP)
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
