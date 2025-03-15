import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/function/show_msg_snack.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_from_field.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_circle_indicator.dart';
import 'package:flutter_ecommerce_app/presentaion/auth/bloc/cubit/auth_cubit.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSucess) {
          Navigator.pop(context);
          showMsgSnackBar(context, "Email was Sent");
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is AuthLoading
              ? const CustomCircularIndicator()
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Enter Your Email To Reset Password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Card(
                            color: AppColors.kWhiteColor,
                            margin: const EdgeInsets.all(24),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
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
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.kPrimaryColor,
                                      foregroundColor: AppColors.kWhiteColor,
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().resetPassword(
                                            email: _emailController.text);
                                      }
                                    },
                                    child: const Text(
                                      'Reset',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
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
    super.dispose();
  }
}
