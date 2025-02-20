import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/helper/navigation/app_navigation.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_circle_indicator.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/bloc/cubit/auth_cubit.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/login/login_view.dart';
import 'package:flutter_ecommerce_app/presentaion/main/main_page.dart';

import '../../../core/function/show_msg_snack.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/build_button.dart';
import '../../../core/widgets/build_text_button.dart';
import '../../../core/widgets/build_text_from_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

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
                                    label: 'Name',
                                    hintText: 'Name',
                                    controller: _nameController,
                                    keyboardType: TextInputType.name,
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
                                    label: 'Email',
                                    hintText: 'Email',
                                    controller: _emailController,
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
                                    controller: _passwordController,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BuildButton(
                                    text: 'Sign Up',
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().signUp(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                              name: _nameController.text,
                                            );
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  BuildButton(
                                    text: 'Sign Up With Google',
                                    onPressed: () => context
                                        .read<AuthCubit>()
                                        .nativeGoogleSignIn(),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Aleardy have an account?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      BuildTextButton(
                                        text: 'Login',
                                        onPressed: () {
                                          AppNavigator.pushAndRemove(
                                              context, const LoginView());
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
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
