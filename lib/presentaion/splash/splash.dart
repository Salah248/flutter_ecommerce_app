import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/helper/navigation/app_navigation.dart';
import 'package:flutter_ecommerce_app/core/resources/assets.dart';
import 'package:flutter_ecommerce_app/presentaion/main/main_page.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/login/login_view.dart';
import 'package:flutter_ecommerce_app/presentaion/splash/bloc/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          AppNavigator.pushReplacement(context, const LoginView());
        } else {
          AppNavigator.pushReplacement(context, MainPageView());
        }
      },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  ImageAsset.splash,
                ),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
