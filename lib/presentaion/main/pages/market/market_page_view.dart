import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_from_field.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/widgets/custom_product_item.dart';

class MarketPageView extends StatelessWidget {
  const MarketPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                'Welcom To our Market',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
