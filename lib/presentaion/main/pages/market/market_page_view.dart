import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/helper/navigation/app_navigation.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_from_field.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_circle_indicator.dart';
import 'package:flutter_ecommerce_app/presentaion/main/bloc/cubit/main_data_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/Home/widgets/search_content.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/widgets/custom_product_item.dart';

class MarketPageView extends StatefulWidget {
  const MarketPageView({super.key, this.query});
  final String? query;

  @override
  State<MarketPageView> createState() => _MarketPageViewState();
}

class _MarketPageViewState extends State<MarketPageView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose(); // إغلاق FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                'Welcom To our Market',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextFormField(
              label: 'Search',
              hintText: 'Search in Market...',
              controller: _searchController,
              focusNode: _searchFocusNode, // ربط FocusNode
              suffixIcon: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  iconSize: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: AppColors.kPrimaryColor,
                ),
                onPressed: () {
                  if (_searchController.text.isNotEmpty) {
                    // إغلاق الكيبورد
                    _searchFocusNode.unfocus();

                    // الانتقال إلى صفحة البحث
                    AppNavigator.push(
                      context,
                      SearchContent(query: _searchController.text),
                    );
                  }
                  _searchController.clear();
                },
                label: const Icon(
                  Icons.search,
                  color: AppColors.kWhiteColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocProvider(
              create: (context) =>
                  MainDataCubit()..getProducts(query: widget.query),
              child: BlocConsumer<MainDataCubit, MainDataState>(
                listener: (context, state) {
                  // يمكنك إضافة استجابات للحالات هنا إذا لزم الأمر
                },
                builder: (context, state) {
                  if (state is MainDataLoading) {
                    return const CustomCircularIndicator();
                  } else if (state is ProductDataLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.product.length,
                      itemBuilder: (context, index) {
                        final product = state.product[index];
                        return CustomProductItem(
                          product: product,
                          isFavorite: context
                              .read<MainDataCubit>()
                              .checkIsFavorite(state.product[index].productId!),
                        );
                      },
                    );
                  } else if (state is MainDataError) {
                    return Center(
                      child: Text(state.message),
                    );
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
