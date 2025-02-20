import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/presentaion/main/bloc/cubit/nav_bar_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/Home/home_page_view.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/favorites/favorites_page_view.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/market/market_page_view.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/profile/profile_page_view.dart';
import 'package:flutter_ecommerce_app/presentaion/main/widgets/nav_bar.dart';

class MainPageView extends StatelessWidget {
  MainPageView({super.key});
  final List<Widget> pages = [
    const HomePageView(),
    const MarketPageView(),
    const FavoritesPageView(),
    const ProfilePageView()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          NavBarCubit cubit = BlocProvider.of<NavBarCubit>(context);
          return Scaffold(
            body: SafeArea(child: pages[cubit.currentIndex]),
            bottomNavigationBar: Container(
              height: 70,
              decoration: const BoxDecoration(
                color: AppColors.kWhiteColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: NavBar(
                  onTabChange: (index) {
                    cubit.changeCurrentIndex(index);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
