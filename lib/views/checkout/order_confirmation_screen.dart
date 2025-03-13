import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../design_system/app_typography.dart';
import '../../design_system/app_colors.dart';
import '../../common_widgets/custom_button.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 96,
                color: AppColors.success,
              ),
              const SizedBox(height: 24),
              Text(
                'Order Confirmed!',
                style: AppTypography.h4.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your order has been placed successfully. You will receive a confirmation email shortly.',
                style: AppTypography.body1.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              CustomButton(
                onPressed: () => Get.offAllNamed('/orders'),
                text: 'View Orders',
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.offAllNamed('/home'),
                child: Text(
                  'Continue Shopping',
                  style: AppTypography.button.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 