import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';

class BuildTextButton extends StatelessWidget {
  const BuildTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        
        text,
        style: const TextStyle(fontWeight: FontWeight.bold ,color: AppColors.kPrimaryColor,),
      ),
    );
  }
}