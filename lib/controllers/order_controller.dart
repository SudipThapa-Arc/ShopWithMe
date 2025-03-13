import 'package:get/get.dart';
import '../models/order.dart' as models;
import '../services/order_service.dart';
import '../services/auth_service.dart';

class OrderController extends GetxController {
  final OrderService _orderService = Get.find<OrderService>();
  final AuthService _authService = Get.find<AuthService>();

  final orders = RxList<models.Order>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final userId = _authService.currentUser.value?.uid;
      if (userId != null) {
        final userOrders = await _orderService.getUserOrders(userId);
        orders.assignAll(userOrders);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch orders. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshOrders() async {
    await fetchOrders();
  }

  void sortOrdersByDate({bool ascending = false}) {
    orders.sort((a, b) => ascending
        ? a.createdAt.compareTo(b.createdAt)
        : b.createdAt.compareTo(a.createdAt));
  }

  List<models.Order> filterOrdersByStatus(String status) {
    return orders.where((order) => order.status == status).toList();
  }
} 