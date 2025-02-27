import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/helper/navigation/app_navigation.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/widgets/app_bar.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_circle_indicator.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/bloc/cubit/auth_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/forget_password/forget_password.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_button.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_button.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_from_field.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/sign_up/sign_up.dart';
import 'package:flutter_ecommerce_app/presentaion/main/main_page.dart';

import '../../../core/function/show_msg_snack.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSucess) {
          AppNavigator.pushReplacement(context, MainPageView());
        }
        if (state is AuthFailure) {
          showMsgSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = context.read<AuthCubit>();
        return Scaffold(
          body: state is AuthLoading
              ? const CustomCircularIndicator()
              : SingleChildScrollView(
                  child: SafeArea(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const BasicAppbar(
                            hideBack: true,
                            title: Text(
                              'Welcome To our market',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Card(
                            margin: const EdgeInsets.all(24),
                            color: AppColors.kWhiteColor,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  CustomTextFormField(
                                 label: 'Email',
                                    hintText: 'Email',
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This Field is Required ';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextFormField(
                                    label: 'Password',
                                    hintText: 'Password',
                                    controller: passwordController,
                                    obscureText: isPasswordVisible,
                                    keyboardType: TextInputType.visiblePassword,
                                       suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      icon: Icon(isPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This Field is Required ';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      BuildTextButton(
                                        text: 'Forget Password?',
                                        onPressed: () {
                                          AppNavigator.push(
                                              context, const ForgetPassword());
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BuildButton(
                                    text: 'Login',
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  BuildButton(
                                    text: 'Login With Google',
                                    onPressed: () => cubit.nativeGoogleSignIn(),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Don\'t have an account?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      BuildTextButton(
                                        text: 'Sign Up',
                                        onPressed: () {
                                          AppNavigator.push(context, const SignUp());
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
