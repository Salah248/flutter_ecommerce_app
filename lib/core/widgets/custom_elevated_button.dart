import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.child,
    this.shape,
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final OutlinedBorder? shape;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: shape,
        backgroundColor: AppColors.kPrimaryColor,
        foregroundColor: AppColors.kWhiteColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
