import 'dart:async';
import 'package:get/get.dart';
import '../services/product_service.dart';

class SearchController extends GetxController {
  final ProductService _productService = Get.find<ProductService>();
  
  final searchResults = RxList<Map<String, dynamic>>();
  final isLoading = false.obs;
  final sortBy = ''.obs;
  final searchQuery = ''.obs;

  void onSearchQueryChanged(String query) {
    searchQuery.value = query;
    _debounceSearch();
  }

  final _debouncer = Debouncer(delay: Duration(milliseconds: 500));
  void _debounceSearch() {
    _debouncer(() {
      performSearch();
    });
  }

  Future<void> performSearch() async {
    try {
      isLoading.value = true;
      final results = await _productService.searchProducts(
        query: searchQuery.value,
        sortBy: sortBy.value,
      );
      searchResults.assignAll(results);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to search products. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void setSortBy(String sort) {
    if (sortBy.value == sort) {
      sortBy.value = '';
    } else {
      sortBy.value = sort;
    }
    performSearch();
  }

  @override
  void onClose() {
    _debouncer.cancel();
    super.onClose();
  }
}

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }
} 