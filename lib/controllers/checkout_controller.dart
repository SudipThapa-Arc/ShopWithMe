import 'package:get/get.dart';
import '../models/order.dart';
import '../services/order_service.dart';

class CheckoutController extends GetxController {
  final OrderService _orderService = Get.find<OrderService>();
  
  final currentStep = 0.obs;
  final isLoading = false.obs;
  
  // Form data
  final shippingAddress = RxMap<String, dynamic>();
  final paymentMethod = RxMap<String, dynamic>();
  final orderItems = RxList<Map<String, dynamic>>();
  
  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }
  
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }
  
  void updateShippingAddress(Map<String, dynamic> address) {
    shippingAddress.assignAll(address);
  }
  
  void updatePaymentMethod(Map<String, dynamic> payment) {
    paymentMethod.assignAll(payment);
  }

  double calculateSubtotal() {
    return orderItems.fold(0.0, (sum, item) => 
      sum + (double.parse(item['price'].toString()) * int.parse(item['quantity'].toString())));
  }

  double calculateShipping() {
    // Simple flat rate shipping
    return orderItems.isEmpty ? 0.0 : 10.0;
  }

  double calculateTax() {
    // Simple 10% tax rate
    return calculateSubtotal() * 0.1;
  }

  double calculateTotal() {
    return calculateSubtotal() + calculateShipping() + calculateTax();
  }
  
  Future<void> placeOrder() async {
    try {
      isLoading.value = true;
      
      final order = Order(
        items: orderItems.toList(),
        shippingAddress: Map<String, dynamic>.from(shippingAddress),
        paymentMethod: Map<String, dynamic>.from(paymentMethod),
        status: 'pending',
        createdAt: DateTime.now(),
      );
      
      await _orderService.createOrder(order);
      Get.offNamed('/order-confirmation');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to place order. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
} 