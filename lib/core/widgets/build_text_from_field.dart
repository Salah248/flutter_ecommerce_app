import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    required this.hintText,
    this.obscuringCharacter = '•',
  });

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  final String obscuringCharacter;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      
      obscuringCharacter: obscuringCharacter,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kBordersideColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kBordersideColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.kGreyColor),
        labelText: label,
        labelStyle: TextStyle(color: AppColors.kGreyColor),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
