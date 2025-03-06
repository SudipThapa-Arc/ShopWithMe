import 'package:get/get.dart';
import 'package:shopwithme/views/category_screen/category_screen.dart';

class AppRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(
        name: '/category',
        page: () => CategoryScreen(
          category: Get.arguments as String,
        ),
      ),
    ];
  }
} 