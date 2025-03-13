import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/cards.dart';
import 'package:shopwithme/common_widgets/empty_state_widget.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - replace with actual addresses
    final List<Map<String, String>> addresses = [
      {
        'type': 'Home',
        'name': 'John Doe',
        'address': '123 Main Street',
        'city': 'New York',
        'state': 'NY',
        'zip': '10001',
        'phone': '+1 (555) 123-4567',
      },
      {
        'type': 'Office',
        'name': 'John Doe',
        'address': '456 Business Ave',
        'city': 'New York',
        'state': 'NY',
        'zip': '10002',
        'phone': '+1 (555) 987-6543',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'My Addresses',
          style: AppTypography.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: addresses.isEmpty
          ? const EmptyStateWidget(
              icon: Icons.location_on_outlined,
              title: 'No Addresses Found',
              message: 'Add a delivery address to get started',
            )
          : ListView.builder(
              padding: EdgeInsets.all(Spacing.md),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: Spacing.md),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  address['type'] == 'Home'
                                      ? Icons.home_outlined
                                      : Icons.business_outlined,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: Spacing.sm),
                                Text(
                                  address['type']!,
                                  style: AppTypography.titleLarge,
                                ),
                              ],
                            ),
                            PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: AppColors.textSecondary,
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text('Edit'),
                                  onTap: () {
                                    // Edit address
                                  },
                                ),
                                PopupMenuItem(
                                  child: Text('Delete'),
                                  onTap: () {
                                    // Delete address
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(height: Spacing.lg),
                        Text(
                          address['name']!,
                          style: AppTypography.bodyLarge,
                        ),
                        SizedBox(height: Spacing.xs),
                        Text(
                          address['address']!,
                          style: AppTypography.bodyMedium,
                        ),
                        Text(
                          '${address['city']}, ${address['state']} ${address['zip']}',
                          style: AppTypography.bodyMedium,
                        ),
                        SizedBox(height: Spacing.xs),
                        Text(
                          address['phone']!,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new address
        },
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: AppColors.onPrimary),
      ),
    );
  }
} 