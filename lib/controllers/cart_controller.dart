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

  void removeItem(int index) {
    cartItems.removeAt(index);
    _updateTotal();
  }

  void addDummyItems() {
    // Clear existing items first to avoid duplicates
    cartItems.clear();
    
    // Add Apple Watch
    cartItems.add(CartItem(
      product: Product(
        id: '1',
        title: 'Apple Watch',
        price: 600.00,
        image: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MKU93_VW_34FR+watch-45-alum-purple-nc-8s_VW_34FR_WF_CO_GEO_US?wid=1400&hei=1400',
        category: 'Electronics',
        colors: ['Purple', 'Black', 'Silver'],
        description: 'Latest Apple Watch with health tracking features',
        brand: 'Apple',
        material: 'Aluminum',
        features: ['Heart Rate Monitor', 'GPS', 'Water Resistant'],
      ),
      quantity: 1
    ));
    
    // Add Modern Chair
    cartItems.add(CartItem(
      product: Product(
        id: '2',
        title: 'Modern Chair',
        price: 500.00,
        image: 'https://www.ikea.com/us/en/images/products/fanbyn-chair-light-blue__0587388_pe672793_s5.jpg',
        category: 'Furniture',
        colors: ['Light Blue', 'Gray', 'White'],
        description: 'Comfortable modern chair with elegant design',
        brand: 'Modern Home',
        material: 'Wood and Fabric',
        features: ['Ergonomic', 'Easy to Clean', 'Durable'],
      ),
      quantity: 1
    ));
    
    // Add Beats Headset
    cartItems.add(CartItem(
      product: Product(
        id: '3',
        title: 'Beats Headset',
        price: 220.00,
        image: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQPJ3?wid=572&hei=572&fmt=jpeg',
        category: 'Electronics',
        colors: ['Purple', 'Black', 'Red'],
        description: 'Premium wireless headphones with noise cancellation',
        brand: 'Beats',
        material: 'Plastic and Leather',
        features: ['Noise Cancellation', 'Wireless', 'Long Battery Life'],
      ),
      quantity: 2
    ));
    
    // Add Blue Shoes
    cartItems.add(CartItem(
      product: Product(
        id: '4',
        title: 'Blue Shoes',
        price: 99.00,
        image: 'https://assets.adidas.com/images/w_600,f_auto,q_auto/57d461193168475e8eecaef800f45e2e_9366/Ultraboost_5.0_DNA_Shoes_Blue_GV8747_01_standard.jpg',
        category: 'Footwear',
        colors: ['Blue', 'Black', 'White'],
        description: 'Comfortable running shoes with modern design',
        brand: 'SportBrand',
        material: 'Synthetic and Mesh',
        features: ['Breathable', 'Lightweight', 'Cushioned'],
      ),
      quantity: 3
    ));
    
    // Update total
    _updateTotal();
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
} 