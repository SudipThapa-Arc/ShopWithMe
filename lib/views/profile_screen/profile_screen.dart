// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shopwithme/constants/colors.dart';
import 'package:shopwithme/constants/styles.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:shopwithme/views/auth_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopwithme/views/profile_screen/edit_profile.dart';
import 'package:shopwithme/controllers/auth_controller.dart';
import 'package:shopwithme/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController _authController = Get.find<AuthController>();

  Future<void> handleLogout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await _authController.signout();
      
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

  void navigateToEditProfile(UserModel user) {
    print("Navigating to EditProfile with user: ${user.name}"); // Debug print
    Get.to(
      () => EditProfile(currentUser: user),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500),
    )?.then((_) {
      // Refresh profile screen when returning from edit profile
      setState(() {});
    });
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
            onPressed: handleLogout,
                icon: Icon(
              Icons.logout,
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
                  // Profile Header Section with user data
                  FutureBuilder<UserModel?>(
                    future: _authController.getCurrentUser(),
                    builder: (context, snapshot) {
                      return Container(
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
                            Stack(
                              children: [
                              Container(
                                height: min(screenSize.width * 0.25, 120),
                                width: min(screenSize.width * 0.25, 120),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: whiteColor, width: 3),
                                    image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data?.imageUrl ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCbC1JPjywAh3dxU_TJkwR98f9DSx1IOlPEg&s",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                              ),
                            ),
                                if (snapshot.hasData)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                      onTap: () {
                                        if (snapshot.data != null) {
                                          print("Edit button clicked"); // Debug print
                                          navigateToEditProfile(snapshot.data!);
                                        }
                                      },
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
                            ),
                          ],
                        ),
                        SizedBox(height: min(screenSize.width * 0.03, 16)),
                            if (snapshot.connectionState == ConnectionState.waiting)
                              const CircularProgressIndicator(color: whiteColor)
                            else ...[
                        Text(
                                snapshot.data?.name ?? "Loading...",
                          style: TextStyle(
                            color: whiteColor,
                            fontFamily: bold,
                            fontSize: min(screenSize.width * 0.045, 22),
                          ),
                        ),
                        SizedBox(height: min(screenSize.width * 0.01, 8)),
                        Text(
                                snapshot.data?.email ?? "Loading...",
                          style: TextStyle(
                            color: whiteColor.withOpacity(0.9),
                            fontSize: min(screenSize.width * 0.035, 16),
                          ),
                        ),
                      ],
                          ],
                        ),
                      );
                    },
                  ),
                  
                  // Profile Options
                  Padding(
                    padding: EdgeInsets.all(min(screenSize.width * 0.04, 20)),
                    child: FutureBuilder<UserModel?>(
                      future: _authController.getCurrentUser(),
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            buildProfileTile(
                              icon: Icons.person_outline,
                              title: "Edit Profile",
                              color: Colors.blue,
                              screenSize: screenSize,
                              onTap: () {
                                print("Edit profile tile clicked");
                                if (snapshot.data != null) {
                                  navigateToEditProfile(snapshot.data!);
                                }
                              },
                            ),
                            buildProfileTile(
                              icon: Icons.shopping_bag_outlined,
                              title: "My Orders",
                              color: Colors.orange,
                              screenSize: screenSize,
                            ),
                            buildProfileTile(
                              icon: Icons.favorite_border,
                              title: "My Wishlist",
                              color: Colors.red,
                              screenSize: screenSize,
                            ),
                            buildProfileTile(
                              icon: Icons.location_on_outlined,
                              title: "Shipping Address",
                              color: Colors.green,
                              screenSize: screenSize,
                            ),
                          ],
                        );
                      },
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
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
