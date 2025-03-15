import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/constants.dart';
import 'package:flutter_ecommerce_app/core/helper/navigation/app_navigation.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/resources/assets.dart';
import 'package:flutter_ecommerce_app/core/resources/constants.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_circle_indicator.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_search_field.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_text.dart';
import 'package:flutter_ecommerce_app/data/users/model/user_model.dart';
import 'package:flutter_ecommerce_app/presentaion/main/bloc/cubit/main_data_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/Home/widgets/category_view.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/widgets/custom_categorie_item.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/widgets/custom_product_item.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    super.key,
    this.query,
    this.userData,
  });

  final String? query;
  final UserDataModel? userData;

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode(); // إضافة FocusNode

  @override
  void initState() {
    PaymentData.initialize(
      apiKey:
          payMopApiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: iframeId, // Required: Found under Developers -> iframes
      integrationCardId:
          integrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId:
          integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID

      // Optional User Data
      userData: UserData(
        email: widget.userData?.email ??
            "User Email", // Optional: Defaults to 'NA'
        name:
            widget.userData?.name ?? "User Name", // Optional: Defaults to 'NA'
      ),

      // Optional Style Customizations
      style: Style(
        primaryColor: AppColors.kPrimaryColor, // Default: Colors.blue
        scaffoldColor: AppColors.kScaffoldColor, // Default: Colors.white
        appBarBackgroundColor: AppColors.kPrimaryColor, // Default: Colors.blue
        appBarForegroundColor: AppColors.kWhiteColor, // Default: Colors.white
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: AppColors.kWhiteColor,
        ), // Default: ElevatedButton.styleFrom()
        circleProgressColor: AppColors.kPrimaryColor, // Default: Colors.blue
        unselectedColor: Colors.grey, // Default: Colors.grey
      ),
    );
    super.initState();
  }

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
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomSearchField(searchController: _searchController, searchFocusNode: _searchFocusNode),
            ),
            const SizedBox(height: 20),
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
                    return GestureDetector(
                      onTap: () {
                        // الانتقال إلى صفحة الفئة
                        AppNavigator.push(
                          context,
                          CategoryView(category: kTexts[index]),
                        );
                      },
                      child: CustomCategorieItem(
                        icon: kIcons[index],
                        text: kTexts[index],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const CustomText(text: 'Recently Products'),
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

