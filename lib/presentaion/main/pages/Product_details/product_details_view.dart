import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/helper/navigation/app_navigation.dart';
import 'package:flutter_ecommerce_app/core/widgets/app_bar.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_from_field.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_circle_indicator.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_text.dart';
import 'package:flutter_ecommerce_app/domain/home/entity/home_entity.dart';
import 'package:flutter_ecommerce_app/domain/productDetails/entity/products_details_entity.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/bloc/cubit/auth_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/Product_details/bloc/cubit/product_details_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/Product_details/widgets/custom_comment.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/resources/app_colors.dart';
import '../widgets/custom_cached_image.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.product,
    required this.isFavorite,
  });
  final ProductEntity product;
  final bool isFavorite;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..getRates(productId: widget.product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is AddOrUpdateRateLoaded) {
            // إعادة تحميل الصفحة بعد نجاح الإضافة/التحديث
            AppNavigator.pushReplacement(context, widget);
          }
        },
        builder: (context, state) {
          var cubit = context.read<ProductDetailsCubit>();

          return Scaffold(
            appBar: BasicAppbar(
              hideBack: false,
              backgroundColor: AppColors.kPrimaryColor,
              title: Text(
                widget.product.productName ?? 'Product Name',
                style: const TextStyle(color: AppColors.kWhiteColor),
              ),
            ),
            body: state is ProductDetailsLoading
                ? const CustomCircularIndicator()
                : ListView(
                    children: [
                      CachedImage(
                        imageUrl: widget.product.imageUrl ??
                            'https://img.freepik.com/premium-vector/404-tab-red_114341-29.jpg?w=826',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${widget.product.productName}'),
                                Text('${widget.product.price} LE'),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('${cubit.averageRate}'),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    )
                                  ],
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: widget.isFavorite
                                      ? AppColors.kPrimaryColor
                                      : AppColors.kGreyColor,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('product Decription'),
                            const SizedBox(
                              height: 30,
                            ),
                            RatingBar.builder(
                              initialRating: cubit.userRate.toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                cubit.addOrUpdateUserRate(
                                  productId: widget.product.productId!,
                                  data: {
                                    "rate": rating.toInt(),
                                    "for_user": cubit.userId,
                                    "for_product": widget.product.productId,
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextFormField(
                              label: 'Feadback',
                              hintText: 'Type your Feedback',
                              controller: _controller,
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    context.read<AuthCubit>().getUserData();
                                    cubit.addComment(data: {
                                      "comment": _controller.text,
                                      "for_user": cubit.userId,
                                      "for_product": widget.product.productId,
                                      "user_name": context
                                              .read<AuthCubit>()
                                              .userDataModel
                                              ?.name ??
                                          "user name"
                                    });
                                    _controller.clear();
                                  },
                                  icon: const Icon(Icons.send)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(text: 'Comments'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            StreamBuilder(
                                stream: Supabase.instance.client
                                    .from("comments_table")
                                    .stream(primaryKey: ['id'])
                                    .eq(
                                      'for_product',
                                      widget.product.productId!,
                                    )
                                    .order('created_at'),
                                builder: (_, snapshot) {
                                  List<Map<String, dynamic>>? data =
                                      snapshot.data;
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CustomCircularIndicator(),
                                    );
                                  } else if (snapshot.hasData) {
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: data?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        // تحويل كل عنصر إلى CommentsEntity
                                        final commentMap = data?[index]
                                            as Map<String, dynamic>;
                                        final commentEntity =
                                            CommentsEntity.fromJson(commentMap);
                                        return CustomComment(
                                          commentsEntity: commentEntity,
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const Divider(),
                                    );
                                  } else if (!snapshot.hasData) {
                                    return const Center(
                                      child: Text('no comments yet'),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text(
                                          'Something went error, please try again'),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
