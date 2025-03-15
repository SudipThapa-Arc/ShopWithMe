import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/cards.dart';
import 'package:shopwithme/common_widgets/custom_text_field.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'Help & Support',
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
            // Contact Support Card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Support',
                    style: AppTypography.titleLarge,
                  ),
                  SizedBox(height: Spacing.sm),
                  Text(
                    'We\'re here to help! Send us your query and we\'ll get back to you as soon as possible.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.lg),
                  CustomTextField(
                    label: 'Subject',
                    hint: 'Enter the subject of your query',
                  ),
                  SizedBox(height: Spacing.md),
                  CustomTextField(
                    label: 'Message',
                    hint: 'Describe your issue or question',
                    maxLines: 5,
                  ),
                  SizedBox(height: Spacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Submit support request
                        Get.snackbar(
                          'Success',
                          'Your message has been sent. We\'ll get back to you soon.',
                          backgroundColor: AppColors.success,
                          colorText: AppColors.onPrimary,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        padding: EdgeInsets.symmetric(vertical: Spacing.md),
                      ),
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: Spacing.lg),
            
            // FAQs Card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequently Asked Questions',
                    style: AppTypography.titleLarge,
                  ),
                  SizedBox(height: Spacing.md),
                  _buildFaqItem(
                    'How do I track my order?',
                    'You can track your order in the My Orders section. Click on any order and select "Track Order" to see real-time updates.',
                  ),
                  _buildFaqItem(
                    'What payment methods do you accept?',
                    'We accept credit/debit cards, PayPal, and various digital wallets. You can manage your payment methods in the Payment Methods section.',
                  ),
                  _buildFaqItem(
                    'How can I return an item?',
                    'To return an item, go to My Orders, select the order containing the item, and click "Return Item". Follow the instructions to complete the return process.',
                  ),
                  _buildFaqItem(
                    'How long does delivery take?',
                    'Delivery times vary by location and shipping method. Standard delivery typically takes 3-5 business days, while express delivery takes 1-2 business days.',
                  ),
                ],
              ),
            ),
            
            SizedBox(height: Spacing.lg),
            
            // Contact Info Card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information',
                    style: AppTypography.titleLarge,
                  ),
                  SizedBox(height: Spacing.md),
                  _buildContactItem(
                    Icons.email_outlined,
                    'Email',
                    'support@shopwithme.com',
                  ),
                  _buildContactItem(
                    Icons.phone_outlined,
                    'Phone',
                    '+1 (555) 123-4567',
                  ),
                  _buildContactItem(
                    Icons.access_time,
                    'Business Hours',
                    'Mon-Fri, 9:00 AM - 6:00 PM EST',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: AppTypography.bodyLarge.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              Spacing.md,
              0,
              Spacing.md,
              Spacing.md,
            ),
            child: Text(
              answer,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: Spacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          SizedBox(width: Spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.labelLarge,
              ),
              Text(
                content,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 