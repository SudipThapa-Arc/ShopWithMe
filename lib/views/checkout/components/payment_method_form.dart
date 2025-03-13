import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/checkout_controller.dart';
import '../../../common_widgets/custom_text_field.dart';
import '../../../design_system/app_typography.dart';
import '../../../design_system/app_colors.dart';

class PaymentMethodForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final CheckoutController controller = Get.find();

  PaymentMethodForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Information',
            style: AppTypography.h6.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            label: 'Card Number',
            keyboardType: TextInputType.number,
            onChanged: (value) => controller.updatePaymentMethod({
              ...controller.paymentMethod,
              'cardNumber': value,
            }),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter your card number' : null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'Expiry Date',
                  hint: 'MM/YY',
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.updatePaymentMethod({
                    ...controller.paymentMethod,
                    'expiryDate': value,
                  }),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter expiry date' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  label: 'CVV',
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.updatePaymentMethod({
                    ...controller.paymentMethod,
                    'cvv': value,
                  }),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter CVV' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Card Holder Name',
            onChanged: (value) => controller.updatePaymentMethod({
              ...controller.paymentMethod,
              'cardHolderName': value,
            }),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter card holder name' : null,
          ),
          const SizedBox(height: 24),
          Text(
            'Billing Address',
            style: AppTypography.subtitle1.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: true,
            onChanged: (value) {
              // TODO: Implement billing address toggle
            },
            title: Text(
              'Same as shipping address',
              style: AppTypography.body2,
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
} 