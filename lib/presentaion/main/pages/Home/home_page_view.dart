import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/resources/assets.dart';
import 'package:flutter_ecommerce_app/core/resources/constants.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_from_field.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_circle_indicator.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_text.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/Home/bloc/cubit/home_data_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/widgets/custom_categorie_item.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/widgets/custom_product_item.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            CustomTextFormField(
              label: 'Search',
              hintText: 'Search in Market...',
              suffixIcon: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  iconSize: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: AppColors.kPrimaryColor,
                ),
                onPressed: () {},
                label: const Icon(
                  Icons.search,
                  color: AppColors.kWhiteColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(ImageAsset.buy),
            const SizedBox(height: 20),
            const CustomText(text: 'Popular Categories'),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ListView.builder(
                  itemCount: kIcons.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CustomCategorieItem(
                      icon: kIcons[index],
                      text: kTexts[index],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const CustomText(text: 'Recently Products'),
            const SizedBox(
              height: 20,
            ),
            BlocProvider(
              create: (context) => ProductDataCubit()..getProducts(),
              child: BlocConsumer<ProductDataCubit, ProductDataState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is ProductDataLoading) {
                    return const CustomCircularIndicator();
                  } else if (state is ProductDataLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.product.length,
                      itemBuilder: (context, index) {
                        return const CustomProductItem();
                      },
                    );
                  } else if (state is ProductDataError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
