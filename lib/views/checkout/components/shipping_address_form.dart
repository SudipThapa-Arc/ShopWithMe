import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/checkout_controller.dart';
import '../../../common_widgets/custom_text_field.dart';

class ShippingAddressForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final CheckoutController controller = Get.find();

  ShippingAddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Full Name',
            onChanged: (value) => controller.updateShippingAddress({
              ...controller.shippingAddress,
              'fullName': value,
            }),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter your full name' : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Street Address',
            onChanged: (value) => controller.updateShippingAddress({
              ...controller.shippingAddress,
              'street': value,
            }),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter your street address' : null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'City',
                  onChanged: (value) => controller.updateShippingAddress({
                    ...controller.shippingAddress,
                    'city': value,
                  }),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your city' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  label: 'State',
                  onChanged: (value) => controller.updateShippingAddress({
                    ...controller.shippingAddress,
                    'state': value,
                  }),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your state' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'ZIP Code',
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.updateShippingAddress({
                    ...controller.shippingAddress,
                    'zipCode': value,
                  }),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your ZIP code' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  label: 'Phone',
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => controller.updateShippingAddress({
                    ...controller.shippingAddress,
                    'phone': value,
                  }),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your phone number' : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 