import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/helper/navigation/app_navigation.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/widgets/app_bar.dart';
import 'package:flutter_ecommerce_app/presentaion/forget_password/forget_password.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_button.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_button.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_from_field.dart';
import 'package:flutter_ecommerce_app/presentaion/main/main_page.dart';
import 'package:flutter_ecommerce_app/presentaion/sign_up/sign_up.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              BasicAppbar(
                hideBack: true,
                title: Text(
                  'Welcome To our market',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Card(
                margin: EdgeInsets.all(24),
                color: AppColors.kWhiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: 'Email',
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Field is Required ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        label: 'Password',
                        hintText: 'Password',
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.visibility_off),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Field is Required ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BuildTextButton(
                            text: 'Forget Password?',
                            onPressed: () {
                              AppNavigator.push(context, ForgetPassword());
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BuildButton(
                        text: 'Login',
                        onPressed: () {
                          AppNavigator.pushReplacement(context, MainPageView());
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      BuildButton(
                        text: 'Login With Google',
                        onPressed: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          BuildTextButton(
                            text: 'Sign Up',
                            onPressed: () {
                              AppNavigator.push(context, SignUp());
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
    );
  }
}
