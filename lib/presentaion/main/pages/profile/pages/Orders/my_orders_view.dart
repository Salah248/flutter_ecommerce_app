import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/widgets/app_bar.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/widgets/custom_product_item.dart';

import '../../../../../../core/resources/app_colors.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
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
          child: ListView.builder(
            shrinkWrap: false,
            physics: BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return CustomProductItem();
            },
          ),
        ),
      ),
    );
  }
}
