import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/constants.dart';
import 'package:flutter_ecommerce_app/core/function/bloc_observer.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/di.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/bloc/cubit/auth_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/main/main_page.dart';
import 'package:flutter_ecommerce_app/presentaion/splash/bloc/cubit/splash_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/splash/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: baseSupabaseUrl,
    anonKey: apiKey,
  );
  Bloc.observer = MyObserver();
  setUpDi();
  runApp(const OurMarket());
}

class OurMarket extends StatelessWidget {
  const OurMarket({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var client = Supabase.instance.client;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit()..appStarted(),
        ),
        BlocProvider(
          create: (context) => AuthCubit()..getUserData(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.kScaffoldColor,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Our Market',
        home: client.auth.currentUser != null
            ? MainPageView()
            : const SplashPage(),
      ),
    );
  }
}
