import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class NavBar extends StatelessWidget {
   const NavBar({super.key, this.onTabChange});

 final void Function(int)? onTabChange;

  @override
  Widget build(BuildContext context) {
    return GNav(
      onTabChange:onTabChange ,
  rippleColor: AppColors.kPrimaryColor, // tab button ripple color when pressed
  hoverColor: AppColors.kPrimaryColor, // tab button hover color
  duration: const Duration(milliseconds: 400), // tab animation duration
  gap: 8, // the tab button gap between icon and text 
  color: AppColors.kGreyColor, // unselected icon color
  activeColor: AppColors.kWhiteColor, // selected icon and text color
  iconSize: 30, // tab button icon size
  tabBackgroundColor: AppColors.kPrimaryColor, // selected tab background color
  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8), // navigation bar padding
  tabs: const [
    GButton(
      icon: Icons.home,
      text: 'Home',
    ),
    GButton(
      icon: Icons.store,
      text: 'Store',
    ),
    GButton(
      icon: Icons.favorite,
      text: 'Favorite',
    ),
    GButton(
      icon: Icons.person,
      text: 'Profile',
    )
  ]
);
  }
}