
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/widgets/app_bar.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_from_field.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_text.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/Product_details/widgets/custom_comment.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/resources/app_colors.dart';
import '../widgets/custom_cached_image.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        hideBack: false,
        backgroundColor: AppColors.kPrimaryColor,
        title: Text(
          'Product Name',
          style: TextStyle(color: AppColors.kWhiteColor),
        ),
      ),
      body: ListView(
        children: [
          const CachedImage(
            imageUrl:
                'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1u4JMd.img?w=768&h=513&m=6',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('product name'),
                    Text('200 LE'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Text('3 '),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        )
                      ],
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: AppColors.kGreyColor,
                      ),
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
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    log(rating.toString());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  label: 'Feadback',
                  hintText: 'Type your Feedback',
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
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
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) => const CustomComment(),
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

