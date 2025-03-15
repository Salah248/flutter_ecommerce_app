import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/helper/navigation/app_navigation.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_from_field.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/Home/widgets/search_content.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required TextEditingController searchController,
    required FocusNode searchFocusNode,
  }) : _searchController = searchController, _searchFocusNode = searchFocusNode;

  final TextEditingController _searchController;
  final FocusNode _searchFocusNode;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
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
    );
  }
}
