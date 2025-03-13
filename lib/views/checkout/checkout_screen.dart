import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/views/checkout/components/order_summary.dart';
import 'package:shopwithme/views/checkout/components/payment_method_form.dart';
import 'package:shopwithme/views/checkout/components/shipping_address_form.dart';
import '../../controllers/checkout_controller.dart';
import '../../common_widgets/custom_button.dart';
import '../../design_system/app_typography.dart';

class CheckoutScreen extends StatelessWidget {
  final checkoutController = Get.put(CheckoutController());

   CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: AppTypography.h6),
        elevation: 0,
      ),
      body: Obx(() => 
        Stepper(
          currentStep: checkoutController.currentStep.value,
          onStepContinue: () => checkoutController.nextStep(),
          onStepCancel: () => checkoutController.previousStep(),
          steps: [
            Step(
              title: Text('Shipping Address'),
              content: ShippingAddressForm(),
              isActive: checkoutController.currentStep.value >= 0,
            ),
            Step(
              title: Text('Payment Method'),
              content: PaymentMethodForm(),
              isActive: checkoutController.currentStep.value >= 1,
            ),
            Step(
              title: Text('Order Summary'),
              content: OrderSummary(),
              isActive: checkoutController.currentStep.value >= 2,
            ),
          ],
        )
      ),
      bottomNavigationBar: Obx(() => 
        checkoutController.currentStep.value == 2
          ? SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CustomButton(
                  onPressed: () => checkoutController.placeOrder(),
                  text: 'Place Order',
                  isLoading: checkoutController.isLoading.value,
                ),
              ),
            )
          : const SizedBox.shrink()
      ),
    );
  }
} 