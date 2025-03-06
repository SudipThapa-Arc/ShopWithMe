import 'package:get/get.dart';
import 'package:shopwithme/models/product_model.dart';

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs;
  final totalAmount = 0.0.obs;

  void addToCart(Product product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      incrementQuantity(index);
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }
    _updateTotal();
  }

  void incrementQuantity(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
    _updateTotal();
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      cartItems.removeAt(index);
    }
    cartItems.refresh();
    _updateTotal();
  }

  void clearCart() {
    cartItems.clear();
    _updateTotal();
  }

  void _updateTotal() {
    totalAmount.value = cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  void proceedToCheckout() {
    // Implement checkout logic
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
} 