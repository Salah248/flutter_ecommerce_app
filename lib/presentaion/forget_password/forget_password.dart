import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/widgets/build_text_from_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Enter Your Email To Reset Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                color: AppColors.kWhiteColor,
                margin: EdgeInsets.all(24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(label: 'Email', hintText: 'Email',keyboardType: TextInputType.emailAddress,validator: (value) {
                      if (value == null || value.isEmpty) {
                          return 'This Field is Required ';
                        }
                        return null;
                      },),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kPrimaryColor,
                          foregroundColor: AppColors.kWhiteColor,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Send',
                          style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 15),
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
    );
  }
}
