import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_elevated_button.dart';

class CustomProfileElevatedButton extends StatelessWidget {
  const CustomProfileElevatedButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: onPressed ?? () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: AppColors.kWhiteColor,
          ),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.kWhiteColor,
          ),
        ],
      ),
    );
  }
}
