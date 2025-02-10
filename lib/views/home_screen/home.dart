import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/colors.dart';
import 'package:myapp/consts/images.dart';
import 'package:myapp/consts/strings.dart';

import '../../consts/styles.dart';
import '../../controllers/home_controller.dart';

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
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: profile),
    ];

    var navBody = [
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.amber,
      ),
      Container(
        color: Colors.purple,
      ),
      Container(
        color: Colors.cyan,
      ),
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
