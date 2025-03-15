import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/cards.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'Privacy Policy',
          style: AppTypography.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last Updated: March 13, 2024',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.md),
                  Text(
                    'Introduction',
                    style: AppTypography.titleLarge,
                  ),
                  SizedBox(height: Spacing.sm),
                  Text(
                    'Welcome to ShopWithMe. We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our app.',
                    style: AppTypography.bodyMedium,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: Spacing.lg),
            
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Information We Collect',
                    style: AppTypography.titleLarge,
                  ),
                  SizedBox(height: Spacing.md),
                  _buildInfoSection(
                    'Personal Information',
                    [
                      'Name and contact details',
                      'Email address',
                      'Phone number',
                      'Shipping and billing addresses',
                      'Payment information',
                    ],
                  ),
                  SizedBox(height: Spacing.md),
                  _buildInfoSection(
                    'Usage Information',
                    [
                      'App usage statistics',
                      'Shopping preferences',
                      'Order history',
                      'Device information',
                      'Location data (with permission)',
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: Spacing.lg),
            
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How We Use Your Information',
                    style: AppTypography.titleLarge,
                  ),
                  SizedBox(height: Spacing.md),
                  _buildInfoSection(
                    'Core Services',
                    [
                      'Processing your orders',
                      'Managing your account',
                      'Providing customer support',
                      'Sending order updates and notifications',
                      'Improving our services',
                    ],
                  ),
                  SizedBox(height: Spacing.md),
                  _buildInfoSection(
                    'Marketing (Optional)',
                    [
                      'Sending promotional offers',
                      'Product recommendations',
                      'Newsletter communications',
                      'Market research and analysis',
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: Spacing.lg),
            
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Rights',
                    style: AppTypography.titleLarge,
                  ),
                  SizedBox(height: Spacing.md),
                  _buildInfoSection(
                    'Data Control',
                    [
                      'Access your personal data',
                      'Request data correction',
                      'Delete your account',
                      'Opt-out of marketing',
                      'Export your data',
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: Spacing.lg),
            
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Us',
                    style: AppTypography.titleLarge,
                  ),
                  SizedBox(height: Spacing.sm),
                  Text(
                    'If you have any questions about our Privacy Policy or how we handle your data, please contact our Data Protection Officer:',
                    style: AppTypography.bodyMedium,
                  ),
                  SizedBox(height: Spacing.md),
                  _buildContactInfo(
                    'Email: privacy@shopwithme.com',
                    'Phone: +1 (555) 123-4567',
                    'Address: 123 Privacy Street, Data City, DC 12345',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.bodyLarge.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: Spacing.sm),
        ...items.map((item) => Padding(
          padding: EdgeInsets.only(
            left: Spacing.md,
            bottom: Spacing.xs,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '•',
                style: AppTypography.bodyMedium,
              ),
              SizedBox(width: Spacing.sm),
              Expanded(
                child: Text(
                  item,
                  style: AppTypography.bodyMedium,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildContactInfo(String email, String phone, String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(email, style: AppTypography.bodyMedium),
        SizedBox(height: Spacing.xs),
        Text(phone, style: AppTypography.bodyMedium),
        SizedBox(height: Spacing.xs),
        Text(address, style: AppTypography.bodyMedium),
      ],
    );
  }
} 