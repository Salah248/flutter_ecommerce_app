import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/resources/app_colors.dart';

class NoInternet extends StatelessWidget {
  final VoidCallback onRetry;
  final String text;

  const NoInternet({super.key, required this.onRetry, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(color: AppColors.kScaffoldColor, fontSize: 20),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimaryColor,
            ),
            child: const Text(
              "Retry",
              style: TextStyle(color: AppColors.kScaffoldColor, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
