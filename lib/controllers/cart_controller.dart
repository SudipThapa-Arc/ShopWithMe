import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/models/product_model.dart';

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs;
  final totalAmount = 0.0.obs;
  final isLoading = false.obs;
  final animatingItemId = ''.obs;

  void addToCart(Product product) {
    // Start loading and animation
    isLoading.value = true;
    animatingItemId.value = product.id;
    
    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final index = cartItems.indexWhere((item) => item.product.id == product.id);
      if (index >= 0) {
        incrementQuantity(index);
      } else {
        cartItems.add(CartItem(product: product, quantity: 1));
      }
      _updateTotal();
      
      // End loading and animation
      isLoading.value = false;
      Future.delayed(const Duration(milliseconds: 300), () {
        animatingItemId.value = '';
      });
      
      // Show success message
      Get.snackbar(
        'Added to Cart',
        '${product.title} has been added to your cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    });
  }

  void incrementQuantity(int index) {
    // Start animation
    animatingItemId.value = cartItems[index].product.id;
    
    cartItems[index].quantity++;
    cartItems.refresh();
    _updateTotal();
    
    // End animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      animatingItemId.value = '';
    });
  }

  void decrementQuantity(int index) {
    // Start animation
    animatingItemId.value = cartItems[index].product.id;
    
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    } else {
      // Prepare for removal animation
      final itemToRemove = cartItems[index];
      
      // Remove after animation completes
      Future.delayed(const Duration(milliseconds: 300), () {
        cartItems.removeAt(index);
        cartItems.refresh();
        
        // Show removal message
        Get.snackbar(
          'Removed from Cart',
          '${itemToRemove.product.title} has been removed from your cart',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        );
      });
    }
    
    _updateTotal();
    
    // End animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      animatingItemId.value = '';
    });
  }

  void clearCart() {
    // Start loading
    isLoading.value = true;
    
    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 500), () {
      cartItems.clear();
      _updateTotal();
      
      // End loading
      isLoading.value = false;
      
      // Show success message
      Get.snackbar(
        'Cart Cleared',
        'All items have been removed from your cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    });
  }

  void _updateTotal() {
    totalAmount.value = cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  void proceedToCheckout() {
    // Start loading
    isLoading.value = true;
    
    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      // End loading
      isLoading.value = false;
      
      // Navigate to checkout or show dialog
      Get.dialog(
        AlertDialog(
          title: const Text('Checkout'),
          content: const Text('Proceed to payment?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                // Implement actual checkout logic
                Get.snackbar(
                  'Order Placed',
                  'Your order has been placed successfully',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 2),
                );
                clearCart();
              },
              child: const Text('Proceed'),
            ),
          ],
        ),
      );
    });
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
} 