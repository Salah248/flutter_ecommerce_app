import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/resources/assets.dart';
import 'package:flutter_ecommerce_app/core/resources/constants.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_from_field.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_text.dart';
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
                label: Icon(
                  Icons.search,
                  color: AppColors.kWhiteColor,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(ImageAsset.buy),
            SizedBox(height: 20),
            CustomText(text: 'Popular Categories'),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            CustomText(text: 'Recently Products'),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics:NeverScrollableScrollPhysics() ,
              itemCount: 10,
              itemBuilder: (context, index) {
                return CustomProductItem();
              },
            )
          ],
        ),
      ),
    );
  }
}
