// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/controllers/auth_controller.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/buttons.dart';
import 'package:shopwithme/design_system/inputs.dart';
// import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AuthController>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Spacing.lg),
              
              // Header
              Text(
                'Create Account',
                style: AppTypography.displayMedium,
              ),
              SizedBox(height: Spacing.xs),
              Text(
                'Sign up to start shopping',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              
              SizedBox(height: Spacing.xxl),

              // Signup Form
              Form(
                child: Column(
                children: [
                    AppInput(
                      label: 'Full Name',
                      hint: 'Enter your full name',
                    controller: nameController,
                      prefixIcon: Icons.person_outline,
                    ),
                    SizedBox(height: Spacing.md),
                    AppInput(
                      label: 'Email',
                      hint: 'Enter your email',
                    controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                    ),
                    SizedBox(height: Spacing.md),
                    AppInput(
                      label: 'Password',
                      hint: 'Create a password',
                    controller: passwordController,
                    obscureText: true,
                      prefixIcon: Icons.lock_outline,
                    ),
                    SizedBox(height: Spacing.md),
                    AppInput(
                      label: 'Confirm Password',
                      hint: 'Confirm your password',
                      controller: confirmPasswordController,
                    obscureText: true,
                      prefixIcon: Icons.lock_outline,
                    ),
                    
                    SizedBox(height: Spacing.lg),

                    // Terms and Conditions
                  Row(
                    children: [
                        Obx(
                          () => Checkbox(
                            value: controller.isCheck.value,
                            onChanged: (value) => controller.toggleCheckbox(),
                            activeColor: AppColors.primary,
                          ),
                        ),
                      Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: AppTypography.bodyMedium,
                              children: [
                                const TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(color: AppColors.textPrimary),
                                ),
                        TextSpan(
                                  text: 'Terms & Conditions',
                                  style: TextStyle(color: AppColors.primary),
                                ),
                                const TextSpan(
                                  text: ' and ',
                                  style: TextStyle(color: AppColors.textPrimary),
                                ),
                        TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(color: AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: Spacing.lg),

                    // Signup Button
                    Obx(
                      () => AppButton(
                        text: 'Create Account',
                        onPressed: () {
                          if (!controller.isCheck.value) {
                            Get.snackbar(
                              'Error',
                              'Please accept terms and conditions',
                              backgroundColor: AppColors.error,
                              colorText: AppColors.onPrimary,
                            );
                            return;
                          }
                          
                          controller.signUp(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        },
                        isLoading: controller.isLoading.value,
                        type: ButtonType.primary,
                        size: ButtonSize.large,
                      ),
                    ),

                    SizedBox(height: Spacing.xl),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: AppTypography.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            'Login',
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
