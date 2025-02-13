import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/presentaion/splash/bloc/cubit/splash_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/splash/splash.dart';

void main() {
  runApp(const OurMarket());
}

class OurMarket extends StatelessWidget {
  const OurMarket({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..appStarted(),
      child: MaterialApp(
        theme:ThemeData(
          scaffoldBackgroundColor: AppColors.kScaffoldColor,
        ) ,
        debugShowCheckedModeBanner: false,
        title: 'Our Market',
        home: SplashPage(),
      ),
    );
  }
}
