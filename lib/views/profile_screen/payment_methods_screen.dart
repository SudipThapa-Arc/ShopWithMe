import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/cards.dart';
import 'package:shopwithme/common_widgets/empty_state_widget.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - replace with actual payment methods
    final List<Map<String, dynamic>> paymentMethods = [
      {
        'type': 'visa',
        'number': '**** **** **** 1234',
        'expiryDate': '12/25',
        'isDefault': true,
      },
      {
        'type': 'mastercard',
        'number': '**** **** **** 5678',
        'expiryDate': '06/24',
        'isDefault': false,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'Payment Methods',
          style: AppTypography.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: paymentMethods.isEmpty
          ? const EmptyStateWidget(
              icon: Icons.payment_outlined,
              title: 'No Payment Methods',
              message: 'Add a payment method to get started',
            )
          : ListView.builder(
              padding: EdgeInsets.all(Spacing.md),
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                final method = paymentMethods[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: Spacing.md),
                  child: AppCard(
                    child: ListTile(
                      leading: _buildCardIcon(method['type']),
                      title: Text(
                        method['number'],
                        style: AppTypography.bodyLarge,
                      ),
                      subtitle: Text(
                        'Expires ${method['expiryDate']}',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (method['isDefault'])
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Spacing.sm,
                                vertical: Spacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Default',
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          SizedBox(width: Spacing.sm),
                          PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: AppColors.textSecondary,
                            ),
                            itemBuilder: (context) => [
                              if (!method['isDefault'])
                                PopupMenuItem(
                                  child: Text('Set as Default'),
                                  onTap: () {
                                    // Set as default
                                  },
                                ),
                              PopupMenuItem(
                                child: Text('Delete'),
                                onTap: () {
                                  // Delete payment method
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new payment method
        },
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: AppColors.onPrimary),
      ),
    );
  }

  Widget _buildCardIcon(String type) {
    IconData icon;
    switch (type.toLowerCase()) {
      case 'visa':
        icon = Icons.credit_card;
        break;
      case 'mastercard':
        icon = Icons.credit_card;
        break;
      default:
        icon = Icons.credit_card;
    }

    return Container(
      padding: EdgeInsets.all(Spacing.sm),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: AppColors.primary),
    );
  }
} 