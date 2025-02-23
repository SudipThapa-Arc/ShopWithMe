// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myapp/constants/colors.dart';
import 'package:myapp/constants/styles.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:myapp/views/auth_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> handleLogout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      Get.offAll(
        () => const Loginscreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500),
      );
    } catch (e) {
      print('Logout Error: $e');
      Get.snackbar(
        'Error',
        'Failed to logout. Please try again.',
        backgroundColor: Colors.red,
        colorText: whiteColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isLargeScreen = screenSize.width > 1200;
    final double maxContentWidth = isLargeScreen ? 1200 : screenSize.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: redColor,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            color: whiteColor,
            fontFamily: bold,
            fontSize: min(screenSize.width * 0.045, 22),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings_outlined,
              color: whiteColor,
              size: min(screenSize.width * 0.05, 24),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: maxContentWidth,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Header Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(min(screenSize.width * 0.04, 20)),
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                    children: [
                        // Profile Image
                      Stack(
                        children: [
                            Container(
                              height: min(screenSize.width * 0.25, 120),
                              width: min(screenSize.width * 0.25, 120),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: whiteColor, width: 3),
                                image: const DecorationImage(
                                  image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCbC1JPjywAh3dxU_TJkwR98f9DSx1IOlPEg&s",
                                  ),
                              fit: BoxFit.cover,
                                ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: golden,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: whiteColor, width: 2),
                                ),
                                child: Icon(
                                Icons.edit,
                                  color: whiteColor,
                                  size: min(screenSize.width * 0.04, 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: min(screenSize.width * 0.03, 16)),
                        // User Info
                        Text(
                          "Roronoa Zoro",
                          style: TextStyle(
                            color: whiteColor,
                            fontFamily: bold,
                            fontSize: min(screenSize.width * 0.045, 22),
                          ),
                        ),
                        SizedBox(height: min(screenSize.width * 0.01, 8)),
                        Text(
                          "Wano Kuni",
                          style: TextStyle(
                            color: whiteColor.withOpacity(0.9),
                            fontSize: min(screenSize.width * 0.035, 16),
                          ),
                  ),
                ],
              ),
            ),

                  // Account Overview Section
            Padding(
                    padding: EdgeInsets.all(min(screenSize.width * 0.04, 20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account Overview",
                          style: TextStyle(
                            color: darkFontGrey,
                            fontFamily: bold,
                            fontSize: min(screenSize.width * 0.04, 20),
                          ),
                        ),
                        SizedBox(height: min(screenSize.width * 0.04, 20)),
                        buildProfileTile(
                          icon: Icons.person_outline,
                          title: "My Profile",
                          color: Colors.blue,
                          screenSize: screenSize,
                        ),
                        buildProfileTile(
                          icon: Icons.shopping_bag_outlined,
                          title: "My Orders",
                          color: redColor,
                          screenSize: screenSize,
                        ),
                        buildProfileTile(
                          icon: Icons.refresh_rounded,
                          title: "Returns & Refunds",
                          color: Colors.purple,
                          screenSize: screenSize,
                        ),
                        buildProfileTile(
                          icon: Icons.location_on_outlined,
                          title: "Shipping Address",
                          color: Colors.orange,
                          screenSize: screenSize,
                        ),
                        buildProfileTile(
                          icon: Icons.payment_outlined,
                          title: "Payment Methods",
                          color: Colors.green,
                          screenSize: screenSize,
                        ),
                        buildProfileTile(
                          icon: Icons.lock_outline,
                          title: "Change Password",
                          color: Colors.red,
                          screenSize: screenSize,
                        ),
                        buildProfileTile(
                          icon: Icons.language,
                          title: "Change Language",
                          color: Colors.teal,
                          screenSize: screenSize,
                        ),
                        SizedBox(height: min(screenSize.width * 0.04, 20)),
                        // Updated Logout Button with confirmation dialog
                        Container(
                          width: double.infinity,
                          height: min(screenSize.height * 0.07, 50),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Logout",
                                titleStyle: TextStyle(
                                  fontFamily: bold,
                                  fontSize: min(screenSize.width * 0.04, 18),
                                ),
                                content: Text(
                                  "Are you sure you want to logout?",
                                  style: TextStyle(
                                    fontSize: min(screenSize.width * 0.035, 16),
                                  ),
                                ),
                                confirm: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    handleLogout();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: redColor,
                                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                                  ),
                                  child: Text(
                                    "Yes, Logout",
                                    style: TextStyle(
                                      fontFamily: bold,
                                      fontSize: min(screenSize.width * 0.035, 16),
                                    ),
                                  ),
                                ),
                                cancel: OutlinedButton(
                                  onPressed: () => Get.back(),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: redColor),
                                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: redColor,
                                      fontFamily: semibold,
                                      fontSize: min(screenSize.width * 0.035, 16),
                                    ),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: redColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: const Icon(Icons.logout, color: whiteColor),
                            label: Text(
                              "Logout",
                              style: TextStyle(
                                color: whiteColor,
                                fontFamily: bold,
                                fontSize: min(screenSize.width * 0.04, 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileTile({
    required IconData icon,
    required String title,
    required Color color,
    required Size screenSize,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: min(screenSize.width * 0.03, 16)),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(min(screenSize.width * 0.02, 10)),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: min(screenSize.width * 0.05, 24)),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: semibold,
            fontSize: min(screenSize.width * 0.035, 16),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: darkFontGrey,
          size: min(screenSize.width * 0.04, 18),
        ),
      ),
    );
  }
}
