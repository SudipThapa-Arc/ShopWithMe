import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/constants/colors.dart';
import 'package:shopwithme/constants/images.dart';
import 'package:shopwithme/constants/strings.dart';
import 'package:shopwithme/views/cart_screen.dart/cart_screen.dart';
import 'package:shopwithme/views/category_screen/category_screen.dart';
import 'package:shopwithme/views/home_screen/home_screen.dart';

import '../../constants/styles.dart';
import '../../controllers/home_controller.dart';
import '../profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navBarItems = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: profile),
    ];

    var navBody = [
      HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() {
            return Expanded(
                child: navBody.elementAt(controller.currentIndex.value));
          }),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.currentIndex.value = index;
          },
          selectedItemColor: redColor,
          selectedLabelStyle:
              const TextStyle(fontSize: 12, fontFamily: semibold),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: navBarItems,
        );
      }),
    );
  }
}
