import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/checkout_controller.dart';
import '../../../design_system/app_typography.dart';
import '../../../design_system/app_colors.dart';

class OrderSummary extends StatelessWidget {
  final CheckoutController controller = Get.find();

   OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: AppTypography.h6.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 24),
        Obx(() => ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.orderItems.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final item = controller.orderItems[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image.network(
                item['image'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(
                item['name'],
                style: AppTypography.subtitle1,
              ),
              subtitle: Text(
                'Quantity: ${item['quantity']}',
                style: AppTypography.body2,
              ),
              trailing: Text(
                '\$${item['price']}',
                style: AppTypography.subtitle1.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            );
          },
        )),
        const SizedBox(height: 24),
        _buildSummaryRow('Subtotal', controller.calculateSubtotal()),
        const SizedBox(height: 8),
        _buildSummaryRow('Shipping', controller.calculateShipping()),
        const SizedBox(height: 8),
        _buildSummaryRow('Tax', controller.calculateTax()),
        const Divider(height: 32),
        _buildSummaryRow(
          'Total',
          controller.calculateTotal(),
          isTotal: true,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: (isTotal ? AppTypography.h6 : AppTypography.body1).copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: (isTotal ? AppTypography.h6 : AppTypography.body1).copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
} 