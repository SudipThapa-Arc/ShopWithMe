// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shopwithme/constants/colors.dart';
import 'package:get/get.dart';
import 'package:shopwithme/views/auth_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopwithme/views/profile_screen/edit_profile.dart';
import 'package:shopwithme/controllers/auth_controller.dart';
import 'package:shopwithme/models/user_model.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/buttons.dart';
import 'package:shopwithme/design_system/cards.dart';
import 'package:shopwithme/views/profile_screen/orders_screen.dart';
import 'package:shopwithme/views/profile_screen/wishlist_screen.dart';
import 'package:shopwithme/views/profile_screen/addresses_screen.dart';
import 'package:shopwithme/views/profile_screen/payment_methods_screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController _authController = Get.find<AuthController>();

  Future<void> handleLogout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await _authController.signout();
      
      Get.offAll(
        () => const Loginscreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500),
      );
    } catch (e) {
      print('Logout Error: $e');
      Get.snackbar(
        'Error',
        'Failed to logout. Please try again.',
        backgroundColor: Colors.red,
        colorText: whiteColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void navigateToEditProfile(UserModel user) {
    print("Navigating to EditProfile with user: ${user.name}"); // Debug print
    Get.to(
      () => EditProfile(currentUser: user),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500),
    )?.then((_) {
      // Refresh profile screen when returning from edit profile
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'Profile',
          style: AppTypography.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.textPrimary),
            onPressed: () {
              if (controller.currentUser.value != null) {
                final user = controller.currentUser.value!;
                final userModel = UserModel(
                  id: user.uid,
                  name: user.displayName ?? '',
                  email: user.email ?? '',
                  phone: user.phoneNumber,
                  imageUrl: user.photoURL,
                );
                Get.to(
                  () => EditProfile(currentUser: userModel),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                )?.then((_) {
                  setState(() {});
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            // Profile Header
            AppCard(
              child: Stack(
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: 'profile-avatar',
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.primary,
                          child: controller.currentUser.value?.photoURL != null
                              ? ClipOval(
                                  child: Image.network(
                                    controller.currentUser.value!.photoURL!,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Text(
                                  controller.currentUser.value?.displayName?[0].toUpperCase() ?? 'U',
                                  style: AppTypography.headlineLarge.copyWith(
                                    color: AppColors.onPrimary,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: Spacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.currentUser.value?.displayName ?? 'User',
                              style: AppTypography.titleLarge,
                            ),
                            SizedBox(height: Spacing.xs),
                            Text(
                              controller.currentUser.value?.email ?? 'email@example.com',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            if (controller.currentUser.value?.phoneNumber != null) ...[
                              SizedBox(height: Spacing.xs),
                              Text(
                                controller.currentUser.value!.phoneNumber!,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.sm,
                        vertical: Spacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: Spacing.xs),
                          Text(
                            'Verified',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Spacing.lg),

            // Orders Section
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Orders',
                        style: AppTypography.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to all orders
                        },
                        child: Row(
                          children: [
                            Text(
                              'View All',
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Spacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildOrderStatus(
                        icon: Icons.pending_outlined,
                        label: 'Pending',
                        count: '2',
                        color: AppColors.warning,
                      ),
                      _buildOrderStatus(
                        icon: Icons.local_shipping_outlined,
                        label: 'Processing',
                        count: '1',
                        color: AppColors.info,
                      ),
                      _buildOrderStatus(
                        icon: Icons.done_all,
                        label: 'Completed',
                        count: '5',
                        color: AppColors.success,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: Spacing.lg),

            // Settings Section
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: Spacing.md,
                      top: Spacing.md,
                      bottom: Spacing.sm,
                    ),
                    child: Text(
                      'Settings',
                      style: AppTypography.titleLarge,
                    ),
                  ),
                  _buildSettingsItem(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Orders',
                    subtitle: 'View and track orders',
                    onTap: () {
                      Get.to(
                        () => const OrdersScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.favorite_border,
                    title: 'Wishlist',
                    subtitle: 'Your favorite items',
                    onTap: () {
                      Get.to(
                        () => const WishlistScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.location_on_outlined,
                    title: 'Addresses',
                    subtitle: 'Manage delivery addresses',
                    onTap: () {
                      Get.to(
                        () => const AddressesScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.payment_outlined,
                    title: 'Payment Methods',
                    subtitle: 'Manage payment options',
                    onTap: () {
                      Get.to(
                        () => const PaymentMethodsScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: Spacing.lg),

            // Support Section
            AppCard(
              child: Column(
                children: [
                  _buildSettingsItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {
                      // Navigate to help
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () {
                      // Navigate to privacy policy
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: Spacing.lg),

            // Logout Button
            AppButton(
              text: 'Logout',
              onPressed: () {
                Get.defaultDialog(
                  title: 'Logout',
                  titleStyle: AppTypography.titleLarge,
                  middleText: 'Are you sure you want to logout?',
                  middleTextStyle: AppTypography.bodyLarge,
                  confirm: AppButton(
                    text: 'Logout',
                    onPressed: () {
                      handleLogout();
                    },
                    type: ButtonType.outline,
                  ),
                  cancel: AppButton(
                    text: 'Cancel',
                    onPressed: () => Get.back(),
                    type: ButtonType.text,
                  ),
                );
              },
              type: ButtonType.outline,
              size: ButtonSize.large,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatus({
    required IconData icon,
    required String label,
    required String count,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Spacing.sm),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        SizedBox(height: Spacing.xs),
        Text(
          label,
          style: AppTypography.bodyMedium,
        ),
        Text(
          count,
          style: AppTypography.labelLarge.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(Spacing.xs),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title, style: AppTypography.bodyLarge),
      subtitle: subtitle != null ? Text(
        subtitle,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ) : null,
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}
