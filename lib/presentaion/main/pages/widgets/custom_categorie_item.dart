import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';

class CustomCategorieItem extends StatelessWidget {
  const CustomCategorieItem({
    super.key,
    this.onPressed,
    required this.icon,
    required this.text,
  });
  
  final void Function()? onPressed;
  final IconData? icon; 
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8), // مسافة أفقية بين العناصر
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30), // لضمان تأثير ripple يناسب الشكل الدائري
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30, // تحديد نصف قطر ثابت
              backgroundColor: AppColors.kPrimaryColor,
              child: Icon(
                icon,
                color: AppColors.kWhiteColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
