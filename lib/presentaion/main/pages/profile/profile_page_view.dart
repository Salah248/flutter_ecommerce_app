import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/helper/navigation/app_navigation.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_circle_indicator.dart';
import 'package:flutter_ecommerce_app/data/users/model/user_model.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/bloc/cubit/auth_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/login/login_view.dart';
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
            BlocProvider(
              create: (context) => AuthCubit()..getUserData(),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSucess) {
                    return AppNavigator.pushReplacement(context, const LoginView());
                  }
                },
                builder: (context, state) {
                  UserDataModel? user = context.read<AuthCubit>().userDataModel;
                  return state is AuthLoading || state is FetchUserDataLoading
                      ? const CustomCircularIndicator()
                      : Center(
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * .66,
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              color: AppColors.kWhiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: AppColors.kPrimaryColor,
                                      radius: 35,
                                      child: Icon(
                                        Icons.person,
                                        color: AppColors.kWhiteColor,
                                        size: 45,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      user?.name ?? 'user name',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      user?.email ??
                                          'user_email@gmail.com',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    CustomProfileElevatedButton(
                                      icon: Icons.person,
                                      text: 'Edit Name',
                                      onPressed: () {
                                        AppNavigator.push(
                                            context, const EditNameView());
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                    CustomProfileElevatedButton(
                                      icon: Icons.shopping_basket,
                                      text: 'My Orders',
                                      onPressed: () {
                                        AppNavigator.push(
                                            context, const MyOrdersView());
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                    CustomProfileElevatedButton(
                                      icon: Icons.logout,
                                      text: 'Logout',
                                      onPressed: () async {
                                        await context
                                            .read<AuthCubit>()
                                            .signOut();
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
