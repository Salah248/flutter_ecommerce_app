import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/helper/navigation/app_navigation.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/profile/pages/Edit_name/edit_name_view.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/profile/pages/Orders/my_orders_view.dart';
import 'package:flutter_ecommerce_app/presentaion/main/pages/profile/widgets/custom_profile_elevated_button.dart';

import '../../../../core/resources/app_colors.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Center(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * .55,
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  color: AppColors.kWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.kPrimaryColor,
                          radius: 35,
                          child: const Icon(
                            Icons.person,
                            color: AppColors.kWhiteColor,
                            size: 45,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Salah Sadoon',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'FlutterDevoloperSalah@gmail.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        CustomProfileElevatedButton(
                          icon: Icons.person,
                          text: 'Edit Name',
                          onPressed: () {
                            AppNavigator.push(context,EditNameView());
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomProfileElevatedButton(
                          icon: Icons.shopping_basket,
                          text: 'My Orders',
                          onPressed: () {
                           AppNavigator.push(context, MyOrdersView());
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomProfileElevatedButton(
                          icon: Icons.logout,
                          text: 'Logout',
                          onPressed: () {
                            // منطق تسجيل الخروج
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
