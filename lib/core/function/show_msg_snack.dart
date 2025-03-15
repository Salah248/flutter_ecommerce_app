
  import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';

void showMsgSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: AppColors.kPrimaryColor,
      ),
    );
  }