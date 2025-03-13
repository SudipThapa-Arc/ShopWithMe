import 'package:get/get.dart';
import 'package:shopwithme/views/category_screen/category_screen.dart';
import '../views/checkout/checkout_screen.dart';
import '../views/checkout/order_confirmation_screen.dart';
import '../views/orders/order_history_screen.dart';
import '../views/search/search_screen.dart';
import '../middleware/auth_middleware.dart';

class AppRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(
        name: '/category',
        page: () => CategoryScreen(
          category: Get.arguments as String,
        ),
      ),
      GetPage(
        name: '/checkout',
        page: () => CheckoutScreen(),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: '/order-confirmation',
        page: () => OrderConfirmationScreen(),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: '/orders',
        page: () => OrderHistoryScreen(),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: '/search',
        page: () => SearchScreen(),
      ),
    ];
  }
} 