import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';

class BuildButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const BuildButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kPrimaryColor,
            foregroundColor: AppColors.kWhiteColor,
          ),
          onPressed: onPressed,
          child: Icon(Icons.arrow_forward,color: AppColors.kWhiteColor,),
        )
      ],
    );
  }
}
